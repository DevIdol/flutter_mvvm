import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../config/config.dart';
import '../data/data.dart';

abstract class BaseUserRepository {
  String get generateNewId;
  Stream<List<User>> fetchUsers();
  Stream<User> getUser({required String userId});
  Future<void> upsertUser(User user);
  Future<void> deleteUser(String userId);
  Future<String> uploadProfile({
    required Uint8List picture,
    required String type,
  });
  Future<void> deleteFromStorage(String url);
}

final userRepositoryProvider = Provider.autoDispose<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(),
);

class UserRepositoryImpl implements BaseUserRepository {
  final _dbUser = FirebaseFirestore.instance.collection('Users');
  final _storage = FirebaseStorage.instance;

  @override
  String get generateNewId => _dbUser.doc().id;

  @override
  Stream<List<User>> fetchUsers() {
    try {
      final snapshotData =
          _dbUser.orderBy('createdAt', descending: true).snapshots();

      return snapshotData.map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return User.fromJson(data);
        }).toList();
      });
    } on FirebaseException catch (error) {
      logger.e('Error fetching users: $error');
      return Stream.error('Failed to fetch users');
    }
  }

  @override
  Stream<User> getUser({required String userId}) {
    return _dbUser.doc(userId).snapshots().handleError((dynamic error) {
      if (error is FirebaseException) {
        throw Exception('Error retrieving user data from Firebase.');
      } else {
        throw Exception('An unknown error occurred.');
      }
    }).map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return User.fromJson(snapshot.data()!);
      } else {
        throw Exception('User with ID "$userId" not found.');
      }
    });
  }

  @override
  Future<void> upsertUser(User user) async {
    try {
      // Check for duplicate email
      final querySnapshot =
          await _dbUser.where('email', isEqualTo: user.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingUser = querySnapshot.docs.first.data();
        if (existingUser['id'] != user.id) {
          throw Exception(
              'The email ${user.email} is already in use by another user.');
        }
      }

      await _dbUser.doc(user.id).set(user.toJson());
    } on FirebaseException catch (error) {
      logger.e('Error upserting user: $error');
      throw Exception('Failed to upsert user: ${error.message}');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _dbUser.doc(userId).delete();
    } on FirebaseException catch (error) {
      logger.e('Error deleting user: $error');
      throw Exception('Failed to delete user: ${error.message}');
    }
  }

  @override
  Future<String> uploadProfile({
    required Uint8List picture,
    required String type,
  }) async {
    final pictureId = const Uuid().v4();
    final storageRef = _storage.ref().child('profiles/$pictureId.$type');
    await storageRef.putData(picture);
    return storageRef.getDownloadURL();
  }

  @override
  Future<void> deleteFromStorage(String url) async {
    try {
      await _storage.refFromURL(url).delete();
    } catch (_) {
      return;
    }
  }
}
