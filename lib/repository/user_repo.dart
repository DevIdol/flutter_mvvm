import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../config/config.dart';
import '../data/data.dart';

abstract class BaseUserRepository {
  String get generateNewId;
  Stream<auth.User?> authUserStream();
  Future<void> create(String authUserId);
  Future<void> updateProvider(User user);
  Future<User?> getUser({required String userId});
  Future<String> uploadProfile(Uint8List picture, String type);
  Future<void> deleteFromStorage(String url);
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});

class UserRepositoryImpl implements BaseUserRepository {
  final _auth = auth.FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection('Users');
  final _storage = FirebaseStorage.instance;

  @override
  String get generateNewId => _userCollection.doc().id;

  @override
  Stream<auth.User?> authUserStream() => _auth.authStateChanges();

  @override
  Future<User?> getUser({required String userId}) async {
    final doc = await _userCollection.doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    } else {
      return null;
    }
  }

  @override
  Future<void> create(String authUserId) async {
    final currentUser = _auth.currentUser!;
    final userProviderData = UserProviderData(
      userName: currentUser.displayName ?? '',
      email: currentUser.email!,
      providerType: currentUser.providerData.first.providerId == 'password'
          ? 'email/password'
          : currentUser.providerData.first.providerId,
      uid: currentUser.providerData.first.uid!,
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
      );

      final updatedUser = user.copyWith(
        providerData: [...providerList, newProviderData],
        updatedAt: DateTime.now(),
      );
      await _userCollection.doc(user.id).set(updatedUser.toJson());
    }
  }

  @override
  Future<String> uploadProfile(Uint8List picture, String type) async {
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
  Future<void> deleteFromStorage(String url) async {
    try {
      await _storage.refFromURL(url).delete();
    } catch (e) {
      logger.e('⚡ ERROR in deleteFromStorage: $e');
    }
  }
}
