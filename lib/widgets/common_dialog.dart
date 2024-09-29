import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String message,
  required VoidCallback? okFunction,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              okFunction!();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
