import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../repository/user_repo.dart';
import 'user_upsert_state.dart';

class UserUpsertViewModel extends StateNotifier<UserUpsertState> {
  UserUpsertViewModel(this.user, this.userRepository)
      : super(
          UserUpsertState(
            id: user?.id ?? '',
            firstName: user?.firstName ?? '',
            lastName: user?.lastName ?? '',
            email: user?.email ?? '',
            profile: user?.profile ?? '',
            address: user?.address ?? Address(name: '', location: ''),
            createdAt: user?.createdAt,
            updatedAt: user?.updatedAt,
          ),
        );

  final User? user;
  final BaseUserRepository userRepository;

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setProfileUrl(String url) {
    state = state.copyWith(profile: url);
  }

  void setAddressName(String name) {
    state = state.copyWith(address: state.address!.copyWith(name: name));
  }

  void setAddressLocation(String location) {
    state =
        state.copyWith(address: state.address!.copyWith(location: location));
  }

  void setImageData(Uint8List data) {
    state = state.copyWith(imageData: data);
  }

  Future<void> upsertUser() async {
    if (state.imageData != null) {
      if (state.profile != null) {
        await userRepository.deleteFromStorage(state.profile!);
      }
      final url = await userRepository.uploadProfile(
        picture: state.imageData!,
        type: 'jpg',
      );
      setProfileUrl(url);
    }

    final userToSave = User(
      id: state.id!.isEmpty ? userRepository.generateNewId : state.id,
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      email: state.email.trim(),
      profile: state.profile ?? '',
      address: state.address ?? Address(name: '', location: ''),
      createdAt: state.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await userRepository.upsertUser(userToSave);
    } catch (error) {
      logger.e('Error during upsert: $error');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await userRepository.deleteUser(userId);
    } catch (error) {
      logger.e('Error during delete: $error');
      throw Exception('Failed to delete user: $error');
    }
  }

  Future<Uint8List?> imageData() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    final mimeType = lookupMimeType(image?.name ?? '');
    if (mimeType == null || mimeType.split('/')[0] != 'image') {
      return null;
    }
    return image?.readAsBytes();
  }
}

final userUpsertViewModelNotifierProvider = StateNotifierProvider.autoDispose
    .family<UserUpsertViewModel, UserUpsertState, User?>(
  (ref, user) {
    final userRepoProvider = ref.watch(userRepositoryProvider);
    return UserUpsertViewModel(user, userRepoProvider);
  },
);
