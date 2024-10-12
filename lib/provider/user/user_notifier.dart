import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../config/logger.dart';
import '../../data/data.dart';
import '../../repository/user_repo.dart';
import 'user_state.dart';

final userProviderStream = StreamProvider.family<User?, String>((ref, userId) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUserStream(userId: userId);
});

final userProviderFuture = FutureProvider.family<User?, String>((ref, userId) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUserFuture(userId: userId);
});


final userNotifierProvider = StateNotifierProvider.autoDispose
    .family<UserNotifier, UserEditState, User?>(
  (ref, user) {
    final userRepoProvider = ref.watch(userRepositoryProvider);
    return UserNotifier(user, userRepoProvider);
  },
);

class UserNotifier extends StateNotifier<UserEditState> {
  UserNotifier(this.user, this.userRepository)
      : super(
          UserEditState(
            id: user?.id ?? '',
            userName: user?.providerData?.first.userName ?? '',
            profile: user?.profile ?? '',
            address: user?.address ?? Address(name: '', location: ''),
          ),
        );

  final User? user;
  final BaseUserRepository userRepository;

  void setUserId(String userId) {
    state = state.copyWith(id: userId);
  }

  void setUserName(String userName) {
    state = state.copyWith(userName: userName);
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

  // upload Profile
  Future<void> uploadProfile({required String oldProfileUrl}) async {
    try {
      if (oldProfileUrl.isNotEmpty) {
        await userRepository.deleteFromStorage(oldProfileUrl);
      }
      final url = await userRepository.uploadProfile(
        picture: state.imageData!,
        type: 'jpg',
      );
      setProfileUrl(url);
      if (state.profile != null || state.profile!.isNotEmpty) {
        await userRepository.updateProfileUrl(
            userId: state.id!, profileUrl: state.profile!);
      }
    } catch (_) {
      rethrow;
    }
  }

  // delete Profile
  Future<void> deleteProfile() async {
    try {
      if (state.profile != null || state.profile!.isNotEmpty) {
        await userRepository.deleteFromStorage(state.profile!);
        await userRepository.deleteProfileUrl(userId: state.id!);
        if (mounted) {
          state = state.copyWith(
            profile: '',
          );
        }
      }
    } catch (_) {
      rethrow;
    }
  }

// update username
  Future<void> updateUsername() async {
    if (state.id!.isEmpty || state.userName.isEmpty) return;
    try {
      await userRepository.updateUsername(
          userId: state.id!, newUsername: state.userName.trim());
      if (mounted) {
        state = state.copyWith(
          userName: state.userName,
        );
        logger.d('Username updated successfully');
      }
    } catch (error) {
      logger.e('Error updating username: $error');
      rethrow;
    }
  }

// change password
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      await userRepository.changePassword(
          oldPassword: oldPassword.trim(), newPassword: newPassword.trim());
      logger.d('Password changed successfully');
    } catch (error) {
      logger.e('Error changing password: $error');
      rethrow;
    }
  }

// update address
  Future<void> updateAddress() async {
    if (state.id!.isEmpty || state.address == null) return;
    try {
      final updatedAddress = state.address!;
      await userRepository.updateUserAddress(
        userId: state.id!,
        addressName: updatedAddress.name.trim(),
        addressLocation: updatedAddress.location.trim(),
      );
      if (mounted) {
        state = state.copyWith(
          address: updatedAddress,
        );
        logger.d('Address updated successfully');
      }
    } catch (error) {
      logger.e('Error updating address: $error');
      rethrow;
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

  Future<void> logout() async {
    try {
      await userRepository.signOut();
    } catch (error) {
      logger.e('Error during logout: $error');
      rethrow;
    }
  }
}
