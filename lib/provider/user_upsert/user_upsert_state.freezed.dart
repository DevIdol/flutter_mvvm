// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_upsert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserUpsertState {
  String? get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @NullableAddressConverters()
  Address? get address => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Uint8List? get imageData => throw _privateConstructorUsedError;

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserUpsertStateCopyWith<UserUpsertState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserUpsertStateCopyWith<$Res> {
  factory $UserUpsertStateCopyWith(
          UserUpsertState value, $Res Function(UserUpsertState) then) =
      _$UserUpsertStateCopyWithImpl<$Res, UserUpsertState>;
  @useResult
  $Res call(
      {String? id,
      String firstName,
      String lastName,
      String email,
      String? profile,
      String password,
      @NullableAddressConverters() Address? address,
      @NullableTimestampConverter() DateTime? createdAt,
      @NullableTimestampConverter() DateTime? updatedAt,
      Uint8List? imageData});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$UserUpsertStateCopyWithImpl<$Res, $Val extends UserUpsertState>
    implements $UserUpsertStateCopyWith<$Res> {
  _$UserUpsertStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? profile = freezed,
    Object? password = null,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? imageData = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserUpsertStateImplCopyWith<$Res>
    implements $UserUpsertStateCopyWith<$Res> {
  factory _$$UserUpsertStateImplCopyWith(_$UserUpsertStateImpl value,
          $Res Function(_$UserUpsertStateImpl) then) =
      __$$UserUpsertStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String firstName,
      String lastName,
      String email,
      String? profile,
      String password,
      @NullableAddressConverters() Address? address,
      @NullableTimestampConverter() DateTime? createdAt,
      @NullableTimestampConverter() DateTime? updatedAt,
      Uint8List? imageData});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$UserUpsertStateImplCopyWithImpl<$Res>
    extends _$UserUpsertStateCopyWithImpl<$Res, _$UserUpsertStateImpl>
    implements _$$UserUpsertStateImplCopyWith<$Res> {
  __$$UserUpsertStateImplCopyWithImpl(
      _$UserUpsertStateImpl _value, $Res Function(_$UserUpsertStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? profile = freezed,
    Object? password = null,
    Object? address = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? imageData = freezed,
  }) {
    return _then(_$UserUpsertStateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$UserUpsertStateImpl implements _UserUpsertState {
  const _$UserUpsertStateImpl(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.profile = '',
      this.password = '',
      @NullableAddressConverters() this.address,
      @NullableTimestampConverter() this.createdAt,
      @NullableTimestampConverter() this.updatedAt,
      this.imageData});

  @override
  @JsonKey()
  final String? id;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String? profile;
  @override
  @JsonKey()
  final String password;
  @override
  @NullableAddressConverters()
  final Address? address;
  @override
  @NullableTimestampConverter()
  final DateTime? createdAt;
  @override
  @NullableTimestampConverter()
  final DateTime? updatedAt;
  @override
  final Uint8List? imageData;

  @override
  String toString() {
    return 'UserUpsertState(id: $id, firstName: $firstName, lastName: $lastName, email: $email, profile: $profile, password: $password, address: $address, createdAt: $createdAt, updatedAt: $updatedAt, imageData: $imageData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserUpsertStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.imageData, imageData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      email,
      profile,
      password,
      address,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(imageData));

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserUpsertStateImplCopyWith<_$UserUpsertStateImpl> get copyWith =>
      __$$UserUpsertStateImplCopyWithImpl<_$UserUpsertStateImpl>(
          this, _$identity);
}

abstract class _UserUpsertState implements UserUpsertState {
  const factory _UserUpsertState(
      {final String? id,
      final String firstName,
      final String lastName,
      final String email,
      final String? profile,
      final String password,
      @NullableAddressConverters() final Address? address,
      @NullableTimestampConverter() final DateTime? createdAt,
      @NullableTimestampConverter() final DateTime? updatedAt,
      final Uint8List? imageData}) = _$UserUpsertStateImpl;

  @override
  String? get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get profile;
  @override
  String get password;
  @override
  @NullableAddressConverters()
  Address? get address;
  @override
  @NullableTimestampConverter()
  DateTime? get createdAt;
  @override
  @NullableTimestampConverter()
  DateTime? get updatedAt;
  @override
  Uint8List? get imageData;

  /// Create a copy of UserUpsertState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserUpsertStateImplCopyWith<_$UserUpsertStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
