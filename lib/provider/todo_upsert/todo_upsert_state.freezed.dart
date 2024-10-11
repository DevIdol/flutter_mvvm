// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_upsert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodoUpsertState {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of TodoUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoUpsertStateCopyWith<TodoUpsertState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoUpsertStateCopyWith<$Res> {
  factory $TodoUpsertStateCopyWith(
          TodoUpsertState value, $Res Function(TodoUpsertState) then) =
      _$TodoUpsertStateCopyWithImpl<$Res, TodoUpsertState>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      bool isPublished,
      String userId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class _$TodoUpsertStateCopyWithImpl<$Res, $Val extends TodoUpsertState>
    implements $TodoUpsertStateCopyWith<$Res> {
  _$TodoUpsertStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? isPublished = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoUpsertStateImplCopyWith<$Res>
    implements $TodoUpsertStateCopyWith<$Res> {
  factory _$$TodoUpsertStateImplCopyWith(_$TodoUpsertStateImpl value,
          $Res Function(_$TodoUpsertStateImpl) then) =
      __$$TodoUpsertStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      bool isPublished,
      String userId,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class __$$TodoUpsertStateImplCopyWithImpl<$Res>
    extends _$TodoUpsertStateCopyWithImpl<$Res, _$TodoUpsertStateImpl>
    implements _$$TodoUpsertStateImplCopyWith<$Res> {
  __$$TodoUpsertStateImplCopyWithImpl(
      _$TodoUpsertStateImpl _value, $Res Function(_$TodoUpsertStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? isPublished = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TodoUpsertStateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TodoUpsertStateImpl implements _TodoUpsertState {
  const _$TodoUpsertStateImpl(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.isPublished = false,
      this.userId = '',
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt});

  @override
  @JsonKey()
  final String? id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String? description;
  @override
  @JsonKey()
  final bool isPublished;
  @override
  @JsonKey()
  final String userId;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TodoUpsertState(id: $id, title: $title, description: $description, isPublished: $isPublished, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoUpsertStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      isPublished, userId, createdAt, updatedAt);

  /// Create a copy of TodoUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoUpsertStateImplCopyWith<_$TodoUpsertStateImpl> get copyWith =>
      __$$TodoUpsertStateImplCopyWithImpl<_$TodoUpsertStateImpl>(
          this, _$identity);
}

abstract class _TodoUpsertState implements TodoUpsertState {
  const factory _TodoUpsertState(
          {final String? id,
          final String title,
          final String? description,
          final bool isPublished,
          final String userId,
          @TimestampConverter() required final DateTime createdAt,
          @TimestampConverter() required final DateTime updatedAt}) =
      _$TodoUpsertStateImpl;

  @override
  String? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  bool get isPublished;
  @override
  String get userId;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of TodoUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoUpsertStateImplCopyWith<_$TodoUpsertStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
