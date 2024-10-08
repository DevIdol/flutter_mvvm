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
  return userRepository.getUser(userId: userId);
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

  void setUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  void setNewPassword(String newPassword) {
    state = state.copyWith(newPassword: newPassword);
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
