import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SaveButton extends HookConsumerWidget {
  final UserUpsertViewModel userUpsertViewModelNotifier;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  const SaveButton({
    super.key,
    required this.userUpsertViewModelNotifier,
    required this.context,
    required this.formKey,
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
            ref.watch(loadingProvider.notifier).update((state) => true);
            try {
              await userUpsertViewModelNotifier.upsertUser();
              if (context.mounted) {
                showSnackBar(context, Messages.userSaveSuccess);
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
        child: Text(Messages.saveUserBtnTxt),
      ),
    );
  }
}
