import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SaveButton extends HookConsumerWidget {
  final TodoUpsertNotifier todoUpsertNotifier;
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final String userId;

  const SaveButton({
    super.key,
    required this.todoUpsertNotifier,
    required this.context,
    required this.formKey,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            todoUpsertNotifier.setUserId(userId);
            ref.watch(loadingProvider.notifier).update((state) => true);
            try {
              await todoUpsertNotifier.upsertTodo();
              if (context.mounted) {
                showSnackBar(context, Messages.todoSaveSuccess);
                Navigator.of(context).pop();
              }
            } catch (e) {
              if (context.mounted) {
                if (e is Exception) {
                  showSnackBar(context, e.getMessage);
                } else {
                  showSnackBar(context, e.toString());
                }
              }
            } finally {
              ref.watch(loadingProvider.notifier).update((state) => false);
            }
          }
        },
        child: Text(Messages.saveTodoBtnTxt),
      ),
    );
  }
}
