import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../assets/assets.gen.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../presentation.dart';

class ResetPasswordPage extends HookConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailInputController = useTextEditingController();
    final successMessage = useState<String?>(null);

    return LoadingOverlay(
      child: Scaffold(
        backgroundColor: AppColors.lightColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: AppColors.lightColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(
                padding: const EdgeInsets.all(20),
                color: AppColors.transparent,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (successMessage.value != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            successMessage.value!,
                            style: const TextStyle(
                              color: AppColors.successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      commonTextFormField(
                        maxLength: 40,
                        labelText: 'Email',
                        controller: emailInputController,
                        validator: (value) => Validators.validateRequiredField(
                          value: value,
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            ref
                                .watch(loadingProvider.notifier)
                                .update((state) => true);
                            FocusScope.of(context).unfocus();
                            try {
                              await authStateNotifier.forgotPassword(
                                emailInputController.text,
                              );
                              if (!context.mounted) return;
                              ref
                                  .watch(loadingProvider.notifier)
                                  .update((state) => false);

                              formKey.currentState?.reset();
                              successMessage.value =
                                  'Password reset link has been sent to your email. ${emailInputController.text}';
                              emailInputController.text = '';
                            } on Exception catch (e) {
                              if (!context.mounted) return;
                              ref
                                  .watch(loadingProvider.notifier)
                                  .update((state) => false);
                              showSnackBar(context, e.getMessage);
                            }
                          }
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(
                              color: AppColors.lightColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonDivider(18, 5, true),
                  const Text('or'),
                  commonDivider(18, 5, false),
                ],
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                commonSocialBtn(
                  onPressed: () async {
                    try {
                      await authStateNotifier.googleSignIn();
                    } on Exception catch (e) {
                      if (!context.mounted) return;
                      showSnackBar(context, e.getMessage);
                    }
                  },
                  child: SvgPicture.asset(
                    Assets.icons.socialGoogle,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: commonStyle(13, FontWeight.w400, AppColors.darkColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
