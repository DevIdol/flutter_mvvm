import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/utils.dart';

part 'todo_upsert_state.freezed.dart';

@freezed
class TodoUpsertState with _$TodoUpsertState {
  const factory TodoUpsertState({
    @Default('') String? id,
    @Default('') String title,
    @Default('') String? description,
    @Default(false) bool isPublished,
    @Default('') String userId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _TodoUpsertState;
}
