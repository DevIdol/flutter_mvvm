import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../config/config.dart';
import '../data/data.dart';
import '../utils/utils.dart';

abstract class BaseUserRepository {
  String get generateNewId;
  Stream<auth.User?> authUserStream();
  Future<void> create(String authUserId);
  Future<void> updateProfileUrl({
    required String userId,
    required String profileUrl,
  });
  Future<void> deleteUser({required String userId});
  Future<void> deleteProfileUrl({
    required String userId,
  });
  Future<void> updateProvider(User user);
  Future<User?> getUserFuture({required String userId});
  Stream<User?> getUserStream({required String userId});
  Future<void> updateUsername(
      {required String userId,
      required String providerId,
      required String newUsername});
  Future<void> changePassword(
      {required String oldPassword, required String newPassword});
  Future<void> updateUserAddress({
    required String userId,
    required String addressName,
    required String addressLocation,
  });

  Future<void> signOut();
  Future<String> uploadProfile(
      {required Uint8List picture, required String type});
  Future<void> deleteFromStorage(String url);
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});

class UserRepositoryImpl implements BaseUserRepository {
  final _auth = auth.FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _storage = FirebaseStorage.instance;

  @override
  String get generateNewId => _userCollection.doc().id;

  @override
  Stream<auth.User?> authUserStream() => _auth.authStateChanges();

  @override
  Stream<User?> getUserStream({required String userId}) {
    return _userCollection.doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return User.fromJson(doc.data()!);
      } else {
        return null;
      }
    });
  }

  @override
  Future<User?> getUserFuture({required String userId}) async {
    final doc = await _userCollection.doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    } else {
      return null;
    }
  }

  @override
  Future<void> create(String authUserId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;
    final userProviderData = UserProviderData(
      userName: currentUser.displayName ?? '',
      email: currentUser.email!,
      providerType: currentUser.providerData.first.providerId == 'password'
          ? 'email/password'
          : currentUser.providerData.first.providerId,
      uid: currentUser.providerData.first.uid!,
      photoUrl: currentUser.photoURL ?? '',
    );

    final newUser = User(
      id: authUserId,
      profile: '',
      address: Address(name: '', location: ''),
      providerData: [userProviderData],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _userCollection.doc(authUserId).set(newUser.toJson());
  }

  @override
  Future<void> updateProvider(User user) async {
    final currentUser = _auth.currentUser!;
    final providerType = currentUser.providerData.first.providerId;
    final providerList = user.providerData ?? [];

    final providerExists = providerList.any((provider) =>
        provider.providerType ==
        (providerType == 'password' ? 'email/password' : providerType));

    if (!providerExists) {
      final newProviderData = UserProviderData(
          userName: currentUser.displayName ?? '',
          email: currentUser.email!,
          providerType:
              providerType == 'password' ? 'email/password' : providerType,
          uid: currentUser.providerData.first.uid!,
          photoUrl: currentUser.photoURL ?? '');

      final updatedUser = user.copyWith(
        providerData: [...providerList, newProviderData],
        updatedAt: DateTime.now(),
      );
      await _userCollection.doc(user.id).set(updatedUser.toJson());
    }
  }

  @override
  Future<void> updateProfileUrl({
    required String userId,
    required String profileUrl,
  }) async {
    try {
      await _userCollection.doc(userId).update({
        'profile': profileUrl,
        'updatedAt': DateTime.now(),
      });
      logger.d('Profile URL updated successfully');
    } catch (e) {
      logger.e('⚡ ERROR updating profile URL: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteProfileUrl({
    required String userId,
  }) async {
    try {
      await _userCollection.doc(userId).update({
        'profile': '',
        'updatedAt': DateTime.now(),
      });
      logger.d('Profile URL updated successfully');
    } catch (e) {
      logger.e('⚡ ERROR updating profile URL: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateUsername({
    required String userId,
    required String providerId,
    required String newUsername,
  }) async {
    try {

      final userDoc = await _userCollection.doc(userId).get();
      final userData = userDoc.data() ?? {};

      List<dynamic> providerDataList = userData['providerData'] ?? [];

      final matchingProvider = providerDataList.firstWhere(
        (data) => data['providerType'] == providerId,
        orElse: () => null,
      );

      if (matchingProvider != null) {
        matchingProvider['userName'] = newUsername;

        await _userCollection.doc(userId).update({
          'providerData': providerDataList,
          'updatedAt': DateTime.now(),
        });

        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          await currentUser.updateDisplayName(newUsername);
        }
      } else {
        logger.e('⚡ No matching provider found for providerId: $providerId');
      }
    } catch (e) {
      logger.e('⚡ ERROR updating username: $e');
      rethrow;
    }
  }

  @override
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        String email = currentUser.email!;

        // Re-authenticate the user
        final credential = auth.EmailAuthProvider.credential(
            email: email, password: oldPassword);
        await currentUser.reauthenticateWithCredential(credential);
        await currentUser.updatePassword(newPassword);
        logger.d('Password updated successfully');
      } catch (e) {
        logger.e('Error updating password: $e');
        rethrow;
      }
    } else {
      throw auth.FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No user is currently logged in.',
      );
    }
  }

// Update Address
  @override
  Future<void> updateUserAddress({
    required String userId,
    required String addressName,
    required String addressLocation,
  }) async {
    try {
      await _userCollection.doc(userId).update({
        'address.name': addressName,
        'address.location': addressLocation,
        'updatedAt': DateTime.now(),
      });
      logger.d('Address updated successfully');
    } catch (e) {
      logger.e('⚡ ERROR updating address: $e');
      rethrow;
    }
  }

  // Sign out user
  @override
  Future<void> signOut() async {
    try {
      final providerId = await CurrentProviderSetting().get() ?? '';
      if (providerId.contains('google')) {
        await GoogleSignIn().signOut();
      }
      await _auth.signOut();
    } catch (e) {
      logger.e('⚡ ERROR in signOut: $e');
      rethrow;
    }
  }

  @override
  Future<String> uploadProfile(
      {required Uint8List picture, required String type}) async {
    try {
      final pictureId = const Uuid().v4();
      final storageRef = _storage.ref('profiles/$pictureId.$type');
      await storageRef.putData(picture);
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e('⚡ ERROR in uploadProfile: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (error) {
      logger.e('Error deleting user: $error');
      rethrow;
    }
  }

  @override
  Future<void> deleteFromStorage(String url) async {
    await _storage.refFromURL(url).delete();
  }
}
