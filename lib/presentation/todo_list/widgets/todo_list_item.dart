import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/data.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({super.key, required this.todo, required this.userId});
  final Todo todo;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListNotifierProvider);
    final isSelected = todoListState.selectedTodoIds.contains(todo.id!);
    final isOwner = todo.userId == userId;

    final userAsyncValue = ref.watch(userProviderStream(todo.userId));

    return userAsyncValue.when(
      data: (user) {
        final ownerName = user?.providerData?.first.userName ?? 'Unknown';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            todo.title,
            style: TextStyle(color: isSelected ? AppColors.errorColor : null),
          ),
          subtitle: Text(
            'Posted by: $ownerName',
            style: TextStyle(
                color: isSelected ? AppColors.greyDarkColor : null,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
          trailing: isOwner && todoListState.selectedTodoIds.isNotEmpty
              ? Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    ref
                        .read(todoListNotifierProvider.notifier)
                        .toggleTodoSelection(todo.id!);
                  },
                )
              : null,
          onTap: () {
            _onTap(context, ref, todo, isOwner, ownerName);
          },
          onLongPress: () {
            _onLongPress(ref, todo, isOwner);
          },
          selected: isSelected,
          tileColor: isSelected ? AppColors.greyColor : null,
        );
      },
      loading: () => const ListTile(
        title: Text('Loading...'),
      ),
      error: (error, stackTrace) => const ListTile(
        title: Text('Error loading user.'),
      ),
    );
  }

  void _onTap(BuildContext context, WidgetRef ref, Todo todo, bool isOwner,
      String ownerName) {
    if (ref.read(todoListNotifierProvider).selectedTodoIds.isNotEmpty &&
        isOwner) {
      ref.read(todoListNotifierProvider.notifier).toggleTodoSelection(todo.id!);
    } else {
      if (ref.read(todoListNotifierProvider).selectedTodoIds.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailPage(
                todo: todo, isOwner: isOwner, ownerName: ownerName),
          ),
        );
      }
    }
  }

  void _onLongPress(WidgetRef ref, Todo todo, bool isOwner) {
    if (ref.read(todoListNotifierProvider).selectedTodoIds.isEmpty && isOwner) {
      ref.read(todoListNotifierProvider.notifier).toggleTodoSelection(todo.id!);
    }
  }
}
