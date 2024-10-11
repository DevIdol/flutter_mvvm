import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data.dart';

part 'todo_list_state.freezed.dart';

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(<Todo>[]) List<Todo> todoList,
    @Default(true) bool isLoading,
    @Default('') String errorMsg,
    @Default(<String>[]) List<String> selectedTodoIds,
  }) = _TodoListState;
}
