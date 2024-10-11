import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../provider/provider.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import 'widgets/todo_list_item.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          if (todoListState.selectedTodoIds.isNotEmpty)
            _buildSelectionToolbar(ref),
          Expanded(
            child: todoListState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : todoListState.todoList.isEmpty
                    ? const Center(child: Text('No todos found.'))
                    : _buildTodoList(ref, todoListState.todoList),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildSelectionToolbar(WidgetRef ref) {
    return Container(
      color: AppColors.greyColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.darkColor),
                onPressed: () {
                  ref.read(todoListNotifierProvider.notifier).clearSelection();
                },
              ),
              const SizedBox(width: 8),
              Text(
                '${ref.watch(todoListNotifierProvider).selectedTodoIds.length} ${ref.watch(todoListNotifierProvider).selectedTodoIds.length > 1 ? 'items' : 'item'} selected',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: IconButton(
              icon: const Icon(Icons.delete, color: AppColors.errorColor),
              onPressed: () {
                if (ref
                    .watch(todoListNotifierProvider)
                    .selectedTodoIds
                    .isNotEmpty) {
                  ref
                      .read(todoListNotifierProvider.notifier)
                      .deleteSelectedTodos();
                } else {
                  ref.read(todoListNotifierProvider.notifier).clearSelection();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(WidgetRef ref, List<Todo> todoList) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todo = todoList[index];
        return TodoListItem(todo: todo, userId: userId);
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add_todo',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoUpsertPage(todo: null, userId: userId),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
