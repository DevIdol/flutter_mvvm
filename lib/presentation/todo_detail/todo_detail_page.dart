import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/todo_upsert/todo_upsert_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../provider/provider.dart';
import '../../utils/utils.dart';

class TodoDetailPage extends HookConsumerWidget {
  const TodoDetailPage({
    super.key,
    required this.todo,
    required this.isOwner,
    required this.ownerName,
  });

  final Todo todo;
  final bool isOwner;
  final String ownerName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TodoUpsertPage(todo: todo, userId: todo.userId),
                  ),
                );
              },
            ),
          if (isOwner)
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: AppColors.errorColor,
              ),
              onPressed: () {
                ref
                    .read(todoListNotifierProvider.notifier)
                    .deleteTodo(todo.id!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Posted by: $ownerName',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyDarkColor,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              todo.description ?? 'No description provided.',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.darkColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Created At: ${todo.createdAt.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.darkColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Updated At: ${todo.updatedAt.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.darkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
