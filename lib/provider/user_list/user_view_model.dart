import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../repository/user_repo.dart';
import 'user_state.dart';

final getUserProvider = StreamProvider.autoDispose.family<User, String>(
  (ref, id) => ref.watch(userRepositoryProvider).getUser(userId: id),
);

final userViewModelNotifierProvider =
    StateNotifierProvider.autoDispose<UserViewModel, UserState>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserViewModel(repo);
});

class UserViewModel extends StateNotifier<UserState> {
  UserViewModel(this._userRepository) : super(const UserState()) {
    _initialize();
  }

  final BaseUserRepository _userRepository;
  List<User>? _originalUserList;

  // Initialize and fetch users
  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);

    try {
      await for (final users in _userRepository.fetchUsers()) {
        _originalUserList = users;
        state = state.copyWith(
          userList: users,
          isLoading: false,
          errorMsg: '',
        );
      }
    } on FirebaseException catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMsg: '${error.message}',
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMsg: 'An unexpected error occurred: $error',
      );
    }
  }

  // Search users based on query
  void searchUsers(String query) {
    final originalList = _originalUserList ?? [];

    // Filter users based on the search query
    final filteredUsers = originalList.where((user) {
      final lowerCaseQuery = query.toLowerCase();
      return user.email.toLowerCase().contains(lowerCaseQuery) ||
          user.firstName.toLowerCase().contains(lowerCaseQuery) ||
          user.lastName.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    state = state.copyWith(userList: filteredUsers);
  }

  void deleteUser({required String userId, required String? profileUrl}) async {
    try {
      if (profileUrl != null || profileUrl!.isNotEmpty) {
        await _userRepository.deleteFromStorage(profileUrl);
      }
      await _userRepository.deleteUser(userId);
    } catch (e) {
      rethrow;
    }
  }
}
