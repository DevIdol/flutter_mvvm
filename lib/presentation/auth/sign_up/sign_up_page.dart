import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final userNameController = useTextEditingController();
    final emailInputController = useTextEditingController();
    final passwordInputController = useTextEditingController();
    final isLoading = useState(false);
    final isPasswordVisible = useState(false);

    return LoadingOverlay(
        child: Scaffold(
      backgroundColor: AppColors.lightColor,
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
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    commonTextFormField(
                      maxLength: 40,
                      labelText: 'Username',
                      controller: userNameController,
                      validator: (value) => Validators.validateRequiredField(
                        value: value,
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 20),
                    commonTextFormField(
                      maxLength: 40,
                      labelText: 'Email',
                      controller: emailInputController,
                      validator: (value) => Validators.validateEmail(
                        value: value,
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    commonTextFormField(
                      maxLength: 26,
                      labelText: 'Password',
                      controller: passwordInputController,
                      validator: (value) => Validators.validatePassword(
                        value: value,
                        labelText: 'Password',
                      ),
                      obscureText: !isPasswordVisible.value,
                      onTogglePassword: (isVisible) {
                        isPasswordVisible.value = !isVisible;
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
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
                                  await authStateNotifier.signUp(
                                    userName: userNameController.text,
                                    email: emailInputController.text,
                                    password: passwordInputController.text,
                                  );
                                  if (!context.mounted) return;
                                   ref.watch(loadingProvider.notifier).update((state) => false);
                                  await showMailConfirmationBox(
                                    context,
                                    emailInputController.text,
                                  );
                                } on Exception catch (e) {
                                  ref
                                      .watch(loadingProvider.notifier)
                                      .update((state) => false);
                                  if (!context.mounted) return;
                                  showSnackBar(context, e.getMessage);
                                }
                              }
                            },
                            child: const Text(
                              'Sign Up',
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Already have an account? Sign In',
                style: commonStyle(13, FontWeight.w400, AppColors.darkColor),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
