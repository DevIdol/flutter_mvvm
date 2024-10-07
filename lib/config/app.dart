import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation/presentation.dart';
import '../provider/provider.dart';
import '../utils/utils.dart';
import 'logger.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserStream = ref.watch(authUserStreamProvider);
    final authStateNotifier = ref.watch(authNotifierProvider.notifier);

    return MaterialApp(
      title: Messages.titleMsg,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: authUserStream.when(
        data: (user) {
          logger.e("User: $user");
          if (user != null) {
            useEffect(() {
              authStateNotifier.getUser(authUserId: user.uid);
              return null;
            }, [user]);

            return const HomePage();
          } else {
            return const SignInPage();
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text('Something is Wrong!')),
      ),
    );
  }
}
