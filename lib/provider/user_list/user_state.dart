import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(<User>[]) List<User> userList,
    @Default(true) bool isLoading,
    @Default('') String errorMsg,
  }) = _UserState;
}
