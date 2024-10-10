import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

Widget buildProfileHeader({
  required BuildContext context,
  required User userData,
  UserProviderData? userProvider,
  required bool showOptions,
  required VoidCallback onEditPressed,
  required VoidCallback onUploadPressed,
  required VoidCallback onRemovePressed,
}) {
  return Center(
    child: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: userData.profile != null && userData.profile!.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: userData.profile!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, size: 50),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      )
                    : userProvider?.photoUrl != null &&
                            userProvider!.photoUrl.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userProvider.photoUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 50),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : const Icon(Icons.person,
                            size: 50, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditPressed,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (showOptions)
            SizedBox(
              width: userData.profile != null && userData.profile!.isNotEmpty
                  ? 240
                  : 120,
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onUploadPressed,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Upload a profile',
                          style: TextStyle(
                            color: AppColors.lightColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (userData.profile != null &&
                        userData.profile!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        height: 20,
                        width: 2,
                        color: AppColors.lightColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onRemovePressed,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Remove profile',
                            style: TextStyle(
                              color: AppColors.lightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            userProvider?.userName ?? 'Unknown User',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userProvider?.email ?? 'Unknown Email',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}

// please create design like github profile change button, show only edit icon in the initial and when i click edit icon show upload and remove
Widget buildUserInfoRow({
  required String title,
  Color? titleColor = AppColors.darkColor,
  required IconData icon,
  Color? iconColor = AppColors.darkColor,
  required VoidCallback onPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      IconButton(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    ],
  );
}

/// Dialog for editing a single text field (eg: username)
Future<void> showEditFieldDialog(
  BuildContext context, {
  required String label,
  required String initialValue,
  required void Function(String) onSave,
}) {
  final formKey = GlobalKey<FormState>();
  String value = initialValue;

  return showCustomDialogForm(
    context: context,
    title: label,
    content: Form(
      key: formKey,
      child: CustomTextField(
        maxLength: 40,
        label: label,
        initialValue: initialValue,
        onChanged: (newValue) => value = newValue,
        isRequired: true,
        validator: (newValue) {
          if (newValue == null || newValue.isEmpty) {
            return '$label is required.';
          }
          return null;
        },
      ),
    ),
    onSave: () async {
      if (formKey.currentState?.validate() ?? false) {
        onSave(value);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    },
  );
}

/// Dialog for editing address (name and location)
Future<void> showEditAddressDialog(
  BuildContext context, {
  required String addressName,
  required String addressLocation,
  required void Function(String, String) onSave,
}) {
  final formKey = GlobalKey<FormState>();
  String name = addressName;
  String location = addressLocation;

  return showCustomDialogForm(
    context: context,
    title: addressName.isEmpty && addressLocation.isEmpty
        ? 'Add Address'
        : 'Edit Address',
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            maxLength: 40,
            label: 'Address Name',
            initialValue: addressName,
            onChanged: (value) => name = value,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            maxLength: 40,
            label: 'Address Location',
            initialValue: addressLocation,
            onChanged: (value) => location = value,
          ),
        ],
      ),
    ),
    onSave: () async {
      if (formKey.currentState?.validate() ?? false) {
        onSave(name, location);
        Navigator.of(context).pop();
      }
    },
  );
}

/// Dialog for change password
Future<void> showChangePasswordDialog(
    BuildContext context, UserNotifier userNotifier) {
  final formKey = GlobalKey<FormState>();
  String oldPassword = '';
  String newPassword = '';

  return showCustomDialogForm(
    context: context,
    title: 'Change Password',
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            maxLength: 26,
            label: 'Old Password',
            initialValue: '',
            onChanged: (value) => oldPassword = value,
            obscureText: true,
            isRequired: true,
            validator: (value) => Validators.validateRequiredField(
              value: value,
              labelText: 'Old Password',
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            maxLength: 26,
            label: 'New Password',
            initialValue: '',
            onChanged: (value) => newPassword = value,
            obscureText: true,
            isRequired: true,
            validator: (value) => Validators.validatePassword(
              value: value,
              labelText: 'New Password',
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            maxLength: 26,
            label: 'Confirm Password',
            initialValue: '',
            obscureText: true,
            isRequired: true,
            validator: (value) {
              if (value != newPassword) {
                return 'Passwords do not match.';
              }
              return null;
            },
            onChanged: (String value) {},
          ),
        ],
      ),
    ),
    onSave: () async {
      if (formKey.currentState?.validate() ?? false) {
        try {
          await userNotifier.changePassword(
              oldPassword: oldPassword, newPassword: newPassword);
          if (!context.mounted) return;
          Navigator.of(context).pop();
          showSnackBar(context, Messages.passChangeSuccessMsg);
        } on Exception catch (e) {
          showSnackBar(context, e.getMessage);
        }
      }
    },
  );
}
