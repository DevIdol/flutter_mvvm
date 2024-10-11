import 'package:flutter/material.dart';
import 'package:flutter_mvvm/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/data.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import 'widgets/save_btn.dart';

class TodoUpsertPage extends HookConsumerWidget {
  TodoUpsertPage({super.key, required this.todo, required this.userId});

  final Todo? todo;
  final String userId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoUpsertState = ref.watch(todoUpsertNotifierProvider(todo));
    final todoUpsertNotifier =
        ref.watch(todoUpsertNotifierProvider(todo).notifier);

    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text(todo == null ? Messages.createTodo : Messages.updateTodo),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Title',
                    initialValue: todoUpsertState.title,
                    onChanged: todoUpsertNotifier.setTitle,
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Description',
                    initialValue: todoUpsertState.description ?? '',
                    onChanged: todoUpsertNotifier.setDescription,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    title: const Text('Published'),
                    value: todoUpsertState.isPublished,
                    onChanged: todoUpsertNotifier.setIsPublished,
                  ),
                  const SizedBox(height: 40),
                  SaveButton(
                    userId: userId,
                    todoUpsertNotifier: todoUpsertNotifier,
                    context: context,
                    formKey: _formKey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
