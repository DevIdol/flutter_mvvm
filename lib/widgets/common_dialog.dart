import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../assets/assets.gen.dart';
import '../presentation/presentation.dart';
import '../utils/utils.dart';
import 'widgets.dart';

// Show Alert confirmation Dialog
Future<void> showConfirmDialog({
  required BuildContext context,
  required String message,
  required VoidCallback? okFunction,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          message,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'CANCEL',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.errorColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            onPressed: () {
              okFunction!();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Show SnackBar in bottom
void showSnackBar(BuildContext context, String msg) {
  final Widget toastWithButton = Container(
    padding: const EdgeInsets.only(left: 19),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFF1E1A1A),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            msg,
            softWrap: true,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const ColoredBox(
          color: Color(0xFFF4F4F4),
          child: SizedBox(
            width: 1,
            height: 23,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 20,
          ),
          color: const Color(0xFFF61202),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ],
    ),
  );
  final snackBar = SnackBar(
    content: toastWithButton,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.zero,
    elevation: 0,
    duration: const Duration(milliseconds: 5000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<bool> showMailConfirmationBox(
  BuildContext context,
  String email,
) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Gap(57),
                SvgPicture.asset(
                  Assets.icons.paperPlane,
                  width: 47,
                  height: 42,
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 21),
                  child: Text(
                    'Verification Email Sent',
                    style:
                        commonStyle(28, FontWeight.w700, AppColors.darkColor),
                  ),
                ),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.only(left: 38, right: 36),
                  child: Text(
                    'We have sent a verification email to $email. '
                    'Please check your inbox and click the link in the email to verify your account and complete the registration. '
                    'You must do this within 72 hours.',
                    style:
                        commonStyle(14, FontWeight.w500, AppColors.darkColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.goldColor,
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil<void>(
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ),
                const Gap(50),
              ],
            ),
          );
        },
      ) ??
      false;
}

/// Common Dialog Form template
Future<void> showCustomDialogForm({
  required BuildContext context,
  required String title,
  required Widget content,
  required Future<void> Function() onSave,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          final screenWidth = MediaQuery.of(context).size.width;
          final dialogWidth = screenWidth < 400 ? screenWidth * 0.98 : 400.0;

          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: dialogWidth,
              child: content,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        Navigator.of(context).pop();
                      },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.errorColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        try {
                          await onSave();
                        } on Exception catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, e.getMessage);
                          }
                        } finally {
                          if (context.mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.lightColor,
                        ),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightColor),
                      ),
              ),
            ],
          );
        },
      );
    },
  );
}
