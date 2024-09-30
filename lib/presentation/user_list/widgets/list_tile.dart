import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/widgets/common_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/data.dart';
import '../../../provider/provider.dart';
import '../../presentation.dart';

class UserListTile extends HookConsumerWidget {
  final User user;

  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.read(userViewModelNotifierProvider.notifier);

    return ListTile(
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: user.profile != null && user.profile!.isNotEmpty
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.profile!,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : const Icon(Icons.person),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserDetailPage(user: user),
          ),
        );
      },
      onLongPress: () async {
        await showConfirmDialog(
          context: context,
          message: 'Are you sure you want to delete this user?',
          okFunction: () {
            _deleteUser(userViewModel: userViewModel, context: context);
          },
        );
      },
    );
  }

  // Delete user with error handling
  Future<void> _deleteUser(
      {required UserViewModel userViewModel,
      required BuildContext context}) async {
    try {
      userViewModel.deleteUser(userId: user.id!, profileUrl: user.profile!);
      showSnackBar(context, 'User deleted successfully');
    } catch (e) {
      showSnackBar(context, 'Failed to delete user: $e');
    }
  }
}
