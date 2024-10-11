import 'package:flutter_mvvm/config/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../repository/todo_repo.dart';
import 'todo_upsert_state.dart';

class TodoUpsertNotifier extends StateNotifier<TodoUpsertState> {
  TodoUpsertNotifier(this.todo, this.todoRepository)
      : super(
          TodoUpsertState(
            id: todo?.id ?? '',
            title: todo?.title ?? '',
            description: todo?.description ?? '',
            isPublished: todo?.isPublished ?? false,
            userId: todo?.userId ?? '',
            createdAt: todo?.createdAt ?? DateTime.now(),
            updatedAt: todo?.updatedAt ?? DateTime.now(),
          ),
        );

  final Todo? todo;
  final BaseTodoRepository todoRepository;

  void setUserId(String userId) {
    state = state.copyWith(userId: userId);
  }

  void setTitle(String? title) {
    state = state.copyWith(title: title!);
  }

  void setDescription(String? description) {
    state = state.copyWith(description: description);
  }

  void setIsPublished(bool? isPublished) {
    state = state.copyWith(isPublished: isPublished!);
  }

  Future<void> upsertTodo() async {
    final todoToSave = Todo(
      id: state.id!.isEmpty ? todoRepository.generateNewId : state.id,
      title: state.title.trim(),
      description: state.description?.trim(),
      isPublished: state.isPublished,
      userId: state.userId,
      createdAt: state.createdAt,
      updatedAt: DateTime.now(),
    );

    try {
      logger.e("Save Todo: $todoToSave");
      await todoRepository.upsertTodo(todoToSave);
    } catch (error) {
      logger.e("Error: $error");
      rethrow;
    }
  }

  Future<void> deleteTodo() async {
    try {
      await todoRepository.deleteTodo(state.id!);
    } catch (error) {
      rethrow;
    }
  }
}

final todoUpsertNotifierProvider = StateNotifierProvider.autoDispose
    .family<TodoUpsertNotifier, TodoUpsertState, Todo?>(
  (ref, todo) {
    final todoRepoProvider = ref.watch(todoRepositoryProvider);
    return TodoUpsertNotifier(todo, todoRepoProvider);
  },
);
