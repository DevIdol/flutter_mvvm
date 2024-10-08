// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserEditState {
  String? get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;
  @NullableAddressConverters()
  Address? get address => throw _privateConstructorUsedError;
  Uint8List? get imageData => throw _privateConstructorUsedError;

  /// Create a copy of UserEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEditStateCopyWith<UserEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEditStateCopyWith<$Res> {
  factory $UserEditStateCopyWith(
          UserEditState value, $Res Function(UserEditState) then) =
      _$UserEditStateCopyWithImpl<$Res, UserEditState>;
  @useResult
  $Res call(
      {String? id,
      String userName,
      String? profile,
      String newPassword,
      String confirmPassword,
      @NullableAddressConverters() Address? address,
      Uint8List? imageData});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$UserEditStateCopyWithImpl<$Res, $Val extends UserEditState>
    implements $UserEditStateCopyWith<$Res> {
  _$UserEditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userName = null,
    Object? profile = freezed,
    Object? newPassword = null,
    Object? confirmPassword = null,
    Object? address = freezed,
    Object? imageData = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }

  /// Create a copy of UserEditState
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
abstract class _$$UserEditStateImplCopyWith<$Res>
    implements $UserEditStateCopyWith<$Res> {
  factory _$$UserEditStateImplCopyWith(
          _$UserEditStateImpl value, $Res Function(_$UserEditStateImpl) then) =
      __$$UserEditStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String userName,
      String? profile,
      String newPassword,
      String confirmPassword,
      @NullableAddressConverters() Address? address,
      Uint8List? imageData});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$UserEditStateImplCopyWithImpl<$Res>
    extends _$UserEditStateCopyWithImpl<$Res, _$UserEditStateImpl>
    implements _$$UserEditStateImplCopyWith<$Res> {
  __$$UserEditStateImplCopyWithImpl(
      _$UserEditStateImpl _value, $Res Function(_$UserEditStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userName = null,
    Object? profile = freezed,
    Object? newPassword = null,
    Object? confirmPassword = null,
    Object? address = freezed,
    Object? imageData = freezed,
  }) {
    return _then(_$UserEditStateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$UserEditStateImpl implements _UserEditState {
  const _$UserEditStateImpl(
      {this.id = '',
      this.userName = '',
      this.profile = '',
      this.newPassword = '',
      this.confirmPassword = '',
      @NullableAddressConverters() this.address,
      this.imageData});

  @override
  @JsonKey()
  final String? id;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String? profile;
  @override
  @JsonKey()
  final String newPassword;
  @override
  @JsonKey()
  final String confirmPassword;
  @override
  @NullableAddressConverters()
  final Address? address;
  @override
  final Uint8List? imageData;

  @override
  String toString() {
    return 'UserEditState(id: $id, userName: $userName, profile: $profile, newPassword: $newPassword, confirmPassword: $confirmPassword, address: $address, imageData: $imageData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEditStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other.imageData, imageData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userName,
      profile,
      newPassword,
      confirmPassword,
      address,
      const DeepCollectionEquality().hash(imageData));

  /// Create a copy of UserEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEditStateImplCopyWith<_$UserEditStateImpl> get copyWith =>
      __$$UserEditStateImplCopyWithImpl<_$UserEditStateImpl>(this, _$identity);
}

abstract class _UserEditState implements UserEditState {
  const factory _UserEditState(
      {final String? id,
      final String userName,
      final String? profile,
      final String newPassword,
      final String confirmPassword,
      @NullableAddressConverters() final Address? address,
      final Uint8List? imageData}) = _$UserEditStateImpl;

  @override
  String? get id;
  @override
  String get userName;
  @override
  String? get profile;
  @override
  String get newPassword;
  @override
  String get confirmPassword;
  @override
  @NullableAddressConverters()
  Address? get address;
  @override
  Uint8List? get imageData;

  /// Create a copy of UserEditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEditStateImplCopyWith<_$UserEditStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
