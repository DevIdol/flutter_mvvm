import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation/presentation.dart';
import '../provider/provider.dart';
import '../utils/utils.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserStream = ref.watch(authUserStreamProvider);
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: Messages.titleMsg,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: authUserStream.when(
        data: (user) {
          if (user != null && user.emailVerified) {
            useEffect(() {
              authStateNotifier.getUserFuture(authUserId: user.uid);
              return null;
            }, [user]);

            return HomePage(
              authUser: user,
            );
          } else {
            return const SignInPage();
          }
        },
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor)),
        error: (error, stack) =>
            const Center(child: Text('Something is Wrong!')),
      ),
    );
  }
}
