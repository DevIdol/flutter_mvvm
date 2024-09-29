import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class UserSearchInput extends StatelessWidget {
  final Function(String) onChanged;

  const UserSearchInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: Messages.searchUser,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
