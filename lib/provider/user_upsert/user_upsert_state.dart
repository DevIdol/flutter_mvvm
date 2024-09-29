import 'dart:typed_data';

import 'package:flutter_mvvm/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

part 'user_upsert_state.freezed.dart';

@freezed
class UserUpsertState with _$UserUpsertState {
  const factory UserUpsertState({
    @Default('') String? id,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String? profile,
    @Default('') String password,
    @NullableAddressConverters() Address? address,
    @NullableTimestampConverter() DateTime? createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
    Uint8List? imageData,
  }) = _UserUpsertState;
}
