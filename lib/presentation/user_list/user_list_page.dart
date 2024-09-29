import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/user_list/user_view_model.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import 'widgets/list_tile.dart';
import 'widgets/search_input.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.watch(userViewModelNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.userList),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: UserSearchInput(onChanged: (query) {
            ref.read(userViewModelNotifierProvider.notifier).searchUsers(query);
          }),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserUpsertPage(user: null),
                ),
              );
            },
          ),
        ],
      ),
      body: userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userViewModel.errorMsg.isNotEmpty
              ? Center(
                  child: Text(userViewModel.errorMsg,
                      style: const TextStyle(color: Colors.red)),
                )
              : userViewModel.userList.isEmpty
                  ? Center(child: Text(Messages.noUser))
                  : ListView.builder(
                      itemCount: userViewModel.userList.length,
                      itemBuilder: (context, index) {
                        final user = userViewModel.userList[index];
                        return UserListTile(user: user);
                      },
                    ),
    );
  }
}
