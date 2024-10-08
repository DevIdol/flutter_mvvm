import 'package:flutter/material.dart';
import 'package:flutter_mvvm/config/config.dart';
import 'package:flutter_mvvm/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/provider.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import 'widgets/account_info_widgets.dart';

class AccountInfoPage extends ConsumerWidget {
  const AccountInfoPage({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProviderStream(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
      ),
      body: userAsyncValue.when(
        data: (user) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileHeader(user!),
                const SizedBox(height: 20),
                CustomCard(
                  padding: const EdgeInsets.all(8),
                  radius: 10,
                  child: Column(
                    children: [
                      buildUserInfoRow(
                        title: user.providerData!.first.userName,
                        icon: Icons.edit,
                        onPressed: () => showEditUsernameDialog(
                          context,
                          label: 'Edit Username',
                          initialValue: user.providerData!.first.userName,
                          onSave: (value) {
                            logger.i('New Username: $value');
                          },
                        ),
                      ),
                      const Divider(),
                      buildUserInfoRow(
                        title: 'Change Password',
                        icon: Icons.edit,
                        onPressed: () async {
                          await showChangePasswordDialog(context);
                        },
                      ),
                      const Divider(),
                      buildUserInfoRow(
                        title: user.address!.name.isNotEmpty &&
                                user.address!.location.isNotEmpty
                            ? '${user.address!.name} ${user.address!.location}'
                            : 'Add New Address',
                        icon: user.address!.name.isNotEmpty &&
                                user.address!.location.isNotEmpty
                            ? Icons.edit
                            : Icons.add,
                        onPressed: () => showEditAddressDialog(
                          context,
                          addressName: user.address!.name,
                          addressLocation: user.address!.location,
                          onSave: (name, location) {
                            logger.i('New Address: $name, $location');
                          },
                        ),
                      ),
                      const Divider(),
                      buildUserInfoRow(
                        title: 'Account Delete',
                        titleColor: AppColors.errorColor,
                        icon: Icons.delete,
                        iconColor: AppColors.errorColor,
                        onPressed: () async {
                          await showConfirmDialog(
                              context: context,
                              message: Messages.deleteAccAlertMsg,
                              okFunction: () {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await showConfirmDialog(
                          context: context,
                          message: Messages.logoutAlertMsg,
                          okFunction: () async {
                            try {
                              final userNotifier =
                                  ref.read(userNotifierProvider(user).notifier);
                              await userNotifier.logout();
                              if (!context.mounted) return;
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                              );
                            } on Exception catch (e) {
                              showSnackBar(context, e.getMessage);
                            }
                          });
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.darkColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
