import 'dart:typed_data';

import 'package:flutter_mvvm/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

part 'user_state.freezed.dart';

@freezed
class UserEditState with _$UserEditState {
  const factory UserEditState({
    @Default('') String? id,
    @Default('') String userName,
    @Default('') String? profile,
    @NullableAddressConverters() Address? address,
    Uint8List? imageData,
  }) = _UserEditState;
}
