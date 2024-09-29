import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/utils.dart';

import '../presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Messages.titleMsg,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const UserListPage(),
    );
  }
}
