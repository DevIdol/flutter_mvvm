import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mvvm/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../provider/provider.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import 'widgets/account_info_widgets.dart';

class AccountInfoPage extends HookConsumerWidget {
  const AccountInfoPage({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProviderStream(userId));

    final showOptions = useState(false);

    void toggleOptions() {
      showOptions.value = !showOptions.value;
    }

    Future<void> uploadProfile(User user) async {
      ref.watch(loadingProvider.notifier).update((state) => true);
      final userNotifier = ref.watch(userNotifierProvider(user).notifier);
      final image = await userNotifier.imageData();

      if (image == null) {
        if (context.mounted) {
          showSnackBar(context, Messages.validateImgMsg);
        }
        ref.watch(loadingProvider.notifier).update((state) => false);
        return;
      }

      try {
        userNotifier.setImageData(image);
        await userNotifier.uploadProfile(oldProfileUrl: user.profile ?? '');
        ref.watch(loadingProvider.notifier).update((state) => false);
        showOptions.value = false;
        if (context.mounted) {
          showSnackBar(context, 'Profile image uploaded successfully!');
        }
      } on Exception catch (e) {
        ref.watch(loadingProvider.notifier).update((state) => false);
        if (context.mounted) {
          showSnackBar(context, e.getMessage);
        }
      }
    }

    Future<void> removeImage(User user) async {
      ref.watch(loadingProvider.notifier).update((state) => true);
      final userNotifier = ref.watch(userNotifierProvider(user).notifier);
      try {
        await userNotifier.deleteProfile();
        ref.watch(loadingProvider.notifier).update((state) => false);
        showOptions.value = false;
        if (context.mounted) {
          showSnackBar(context, 'Profile image removed successfully!');
        }
      } on Exception catch (e) {
        ref.watch(loadingProvider.notifier).update((state) => false);
        if (context.mounted) {
          showSnackBar(context, e.getMessage);
        }
      }
    }

    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Info'),
        ),
        body: userAsyncValue.when(
          data: (user) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileHeader(
                      context: context,
                      userData: user!,
                      showOptions: showOptions.value,
                      onEditPressed: toggleOptions,
                      onUploadPressed: () => uploadProfile(user),
                      onRemovePressed: () => removeImage(user),
                    ),
                    const SizedBox(height: 20),
                    CustomCard(
                      padding: const EdgeInsets.all(8),
                      radius: 10,
                      child: Column(
                        children: [
                          buildUserInfoRow(
                            title: user.providerData!.first.userName,
                            icon: Icons.edit,
                            onPressed: () => showEditFieldDialog(
                              context,
                              label: 'Edit Username',
                              initialValue: user.providerData!.first.userName,
                              onSave: (value) async {
                                try {
                                  final userNotifier = ref.read(
                                      userNotifierProvider(user).notifier);
                                  userNotifier.setUserName(value);
                                  if (userNotifier.mounted) {
                                    await userNotifier.updateUsername();
                                  }
                                } on Exception catch (e) {
                                  if (!context.mounted) return;
                                  showSnackBar(context, e.getMessage);
                                }
                              },
                            ),
                          ),
                          const Divider(),
                          buildUserInfoRow(
                            title: 'Change Password',
                            icon: Icons.edit,
                            onPressed: () async {
                              final userNotifier =
                                  ref.read(userNotifierProvider(user).notifier);
                              await showChangePasswordDialog(
                                  context, userNotifier);
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
                              onSave: (name, location) async {
                                try {
                                  final userNotifier = ref.read(
                                      userNotifierProvider(user).notifier);
                                  userNotifier.setAddressName(name);
                                  userNotifier.setAddressLocation(location);
                                  if (userNotifier.mounted) {
                                    await userNotifier.updateAddress();
                                  }
                                } on Exception catch (e) {
                                  if (!context.mounted) return;
                                  showSnackBar(context, e.getMessage);
                                }
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
                                  final userNotifier = ref.read(
                                      userNotifierProvider(user).notifier);
                                  await userNotifier.logout();
                                  if (!context.mounted) return;
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()),
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
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
