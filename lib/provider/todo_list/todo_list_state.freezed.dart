// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodoListState {
  List<Todo> get todoList => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMsg => throw _privateConstructorUsedError;
  List<String> get selectedTodoIds => throw _privateConstructorUsedError;

  /// Create a copy of TodoListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoListStateCopyWith<TodoListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListStateCopyWith<$Res> {
  factory $TodoListStateCopyWith(
          TodoListState value, $Res Function(TodoListState) then) =
      _$TodoListStateCopyWithImpl<$Res, TodoListState>;
  @useResult
  $Res call(
      {List<Todo> todoList,
      bool isLoading,
      String errorMsg,
      List<String> selectedTodoIds});
}

/// @nodoc
class _$TodoListStateCopyWithImpl<$Res, $Val extends TodoListState>
    implements $TodoListStateCopyWith<$Res> {
  _$TodoListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoList = null,
    Object? isLoading = null,
    Object? errorMsg = null,
    Object? selectedTodoIds = null,
  }) {
    return _then(_value.copyWith(
      todoList: null == todoList
          ? _value.todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTodoIds: null == selectedTodoIds
          ? _value.selectedTodoIds
          : selectedTodoIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoListStateImplCopyWith<$Res>
    implements $TodoListStateCopyWith<$Res> {
  factory _$$TodoListStateImplCopyWith(
          _$TodoListStateImpl value, $Res Function(_$TodoListStateImpl) then) =
      __$$TodoListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Todo> todoList,
      bool isLoading,
      String errorMsg,
      List<String> selectedTodoIds});
}

/// @nodoc
class __$$TodoListStateImplCopyWithImpl<$Res>
    extends _$TodoListStateCopyWithImpl<$Res, _$TodoListStateImpl>
    implements _$$TodoListStateImplCopyWith<$Res> {
  __$$TodoListStateImplCopyWithImpl(
      _$TodoListStateImpl _value, $Res Function(_$TodoListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoList = null,
    Object? isLoading = null,
    Object? errorMsg = null,
    Object? selectedTodoIds = null,
  }) {
    return _then(_$TodoListStateImpl(
      todoList: null == todoList
          ? _value._todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTodoIds: null == selectedTodoIds
          ? _value._selectedTodoIds
          : selectedTodoIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$TodoListStateImpl implements _TodoListState {
  const _$TodoListStateImpl(
      {final List<Todo> todoList = const <Todo>[],
      this.isLoading = true,
      this.errorMsg = '',
      final List<String> selectedTodoIds = const <String>[]})
      : _todoList = todoList,
        _selectedTodoIds = selectedTodoIds;

  final List<Todo> _todoList;
  @override
  @JsonKey()
  List<Todo> get todoList {
    if (_todoList is EqualUnmodifiableListView) return _todoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoList);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMsg;
  final List<String> _selectedTodoIds;
  @override
  @JsonKey()
  List<String> get selectedTodoIds {
    if (_selectedTodoIds is EqualUnmodifiableListView) return _selectedTodoIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTodoIds);
  }

  @override
  String toString() {
    return 'TodoListState(todoList: $todoList, isLoading: $isLoading, errorMsg: $errorMsg, selectedTodoIds: $selectedTodoIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoListStateImpl &&
            const DeepCollectionEquality().equals(other._todoList, _todoList) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            const DeepCollectionEquality()
                .equals(other._selectedTodoIds, _selectedTodoIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_todoList),
      isLoading,
      errorMsg,
      const DeepCollectionEquality().hash(_selectedTodoIds));

  /// Create a copy of TodoListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoListStateImplCopyWith<_$TodoListStateImpl> get copyWith =>
      __$$TodoListStateImplCopyWithImpl<_$TodoListStateImpl>(this, _$identity);
}

abstract class _TodoListState implements TodoListState {
  const factory _TodoListState(
      {final List<Todo> todoList,
      final bool isLoading,
      final String errorMsg,
      final List<String> selectedTodoIds}) = _$TodoListStateImpl;

  @override
  List<Todo> get todoList;
  @override
  bool get isLoading;
  @override
  String get errorMsg;
  @override
  List<String> get selectedTodoIds;

  /// Create a copy of TodoListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoListStateImplCopyWith<_$TodoListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
