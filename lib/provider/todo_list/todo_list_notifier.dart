import 'dart:async';

import 'package:flutter_mvvm/utils/extensions/exception_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../repository/todo_repo.dart';
import 'todo_list_state.dart';

final todoListNotifierProvider =
    StateNotifierProvider.autoDispose<TodoListNotifier, TodoListState>(
  (ref) {
    final todoRepo = ref.watch(todoRepositoryProvider);
    return TodoListNotifier(todoRepo);
  },
);

class TodoListNotifier extends StateNotifier<TodoListState> {
  TodoListNotifier(this._todoRepository) : super(const TodoListState()) {
    _initialize();
  }

  final BaseTodoRepository _todoRepository;
  List<Todo>? _originalTodoList;

  // Stream subscription to manage state updates
  late final StreamSubscription<List<Todo>> _todosSubscription;

  // Initialize and fetch todos
  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);

    try {
      _todosSubscription = _todoRepository.fetchTodos().listen((todos) {
        _originalTodoList = todos;
        state = state.copyWith(
          todoList: todos,
          isLoading: false,
          errorMsg: '',
        );
      }, onError: (error) {
        _handleError(error);
      });
    } catch (error) {
      _handleError(error);
    }
  }

  // Standardized error handling
  void _handleError(dynamic error) {
    state = state.copyWith(
      isLoading: false,
      errorMsg: 'Error fetching todos: ${error.getMessage ?? error}',
    );
  }

  @override
  void dispose() {
    _todosSubscription.cancel();
    super.dispose();
  }

  // Search todos based on query
  void searchTodos(String query) {
    if (_originalTodoList == null) return;

    final lowerCaseQuery = query.toLowerCase();
    final filteredTodos = _originalTodoList!.where((todo) {
      return todo.title.toLowerCase().contains(lowerCaseQuery) ||
          (todo.description?.toLowerCase().contains(lowerCaseQuery) ?? false);
    }).toList();

    state = state.copyWith(todoList: filteredTodos);
  }

  // Toggle selection of a todo
  void toggleTodoSelection(String todoId) {
    final isSelected = state.selectedTodoIds.contains(todoId);
    if (isSelected) {
      state = state.copyWith(
          selectedTodoIds: [...state.selectedTodoIds]..remove(todoId));
    } else {
      state =
          state.copyWith(selectedTodoIds: [...state.selectedTodoIds, todoId]);
    }
  }

  void clearSelection() {
    state = state.copyWith(selectedTodoIds: []);
  }

  // Upsert a todo
  Future<void> upsertTodo(Todo todo) async {
    try {
      await _todoRepository.upsertTodo(todo);
    } on Exception catch (error) {
      state = state.copyWith(
        errorMsg: 'Error saving todo: ${error.getMessage}',
      );
    }
  }

  // Delete a single todo
  Future<void> deleteTodo(String todoId) async {
    try {
      await _todoRepository.deleteTodo(todoId);
    } on Exception catch (error) {
      state = state.copyWith(
        errorMsg: 'Error deleting todo: ${error.getMessage}',
      );
    }
  }

  // Delete selected todos
  Future<void> deleteSelectedTodos() async {
    if (state.selectedTodoIds.isEmpty) return;

    try {
      await _todoRepository.deleteTodos(state.selectedTodoIds);
      state = state.copyWith(selectedTodoIds: []);
    } on Exception catch (error) {
      state = state.copyWith(
        errorMsg: 'Error deleting selected todos: ${error.getMessage}',
      );
    }
  }
}
