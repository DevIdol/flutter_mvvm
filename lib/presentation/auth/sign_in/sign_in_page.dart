import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../assets/assets.gen.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../presentation.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailInputController = useTextEditingController();
    final passwordInputController = useTextEditingController();
    final isPasswordVisible = useState(false);

    return LoadingOverlay(
      child: Scaffold(
        backgroundColor: AppColors.lightColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
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
                            'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          commonTextFormField(
                            maxLength: 40,
                            labelText: 'Email',
                            controller: emailInputController,
                            validator: (value) =>
                                Validators.validateRequiredField(
                              value: value,
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          commonTextFormField(
                            maxLength: 26,
                            labelText: 'Password',
                            controller: passwordInputController,
                            validator: (value) =>
                                Validators.validateRequiredField(
                              value: value,
                              labelText: 'Password',
                            ),
                            obscureText: !isPasswordVisible.value,
                            onTogglePassword: (isVisible) {
                              isPasswordVisible.value = !isVisible;
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordPage(),
                                  ),
                                );
                                formKey.currentState?.reset();
                              },
                              child: Text(
                                'Forgot your password?',
                                style: commonStyle(
                                    13, FontWeight.w400, AppColors.linkColor),
                              ),
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
                                  await authStateNotifier.signIn(
                                    emailInputController.text,
                                    passwordInputController.text,
                                  );
                                  final authUser =
                                      FirebaseAuth.instance.currentUser;
                                  if (authUser != null) {
                                    if (!context.mounted) return;
                                    Navigator.of(context)
                                        .pushAndRemoveUntil<void>(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(authUser: authUser),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                } on Exception catch (e) {
                                  if (!context.mounted) return;
                                  showSnackBar(context, e.getMessage);
                                } finally {
                                  if (context.mounted) {
                                    ref
                                        .read(loadingProvider.notifier)
                                        .update((state) => false);
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.lightColor,
                                fontWeight: FontWeight.bold,
                              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonSocialBtn(
                        onPressed: () async {
                          ref
                              .read(loadingProvider.notifier)
                              .update((state) => true);
                          try {
                            await authStateNotifier.googleSignIn();
                            final authUser = FirebaseAuth.instance.currentUser;
                            if (authUser != null) {
                              if (!context.mounted) return;
                              Navigator.of(context).pushAndRemoveUntil<void>(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(authUser: authUser),
                                ),
                                (route) => false,
                              );
                            }
                          } on Exception catch (e) {
                            if (!context.mounted) return;
                            showSnackBar(context, e.getMessage);
                          } finally {
                            if (context.mounted) {
                              ref
                                  .read(loadingProvider.notifier)
                                  .update((state) => false);
                            }
                          }
                        },
                        child: SvgPicture.asset(Assets.icons.socialGoogle),
                      ),
                    ],
                  ),
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
                      style:
                          commonStyle(13, FontWeight.w400, AppColors.darkColor),
                    ),
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
