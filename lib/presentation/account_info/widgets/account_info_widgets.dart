import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

Widget buildProfileHeader(User userData) {
  return Center(
    child: Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: userData.profile != null && userData.profile!.isNotEmpty
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userData.profile!,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
        ),
        const SizedBox(height: 10),
        Text(
          '${userData.providerData?.first.userName}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const SizedBox(height: 5),
        Text(
          userData.providerData!.first.email,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.darkColor,
          ),
        ),
      ],
    ),
  );
}

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

// Dialog for change username
Future<void> showEditUsernameDialog(
  BuildContext context, {
  required String label,
  required String initialValue,
  required void Function(String) onSave,
}) {
  String username = initialValue;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(label),
        content: CustomTextField(
          label: label,
          initialValue: initialValue,
          onChanged: (value) => username = value,
          isRequired: true,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.errorColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.lightColor),
            ),
            onPressed: () {
              if (username.isNotEmpty) {
                onSave(username);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

// Dialog for editing address (name and location)
Future<void> showEditAddressDialog(
  BuildContext context, {
  required String addressName,
  required String addressLocation,
  required void Function(String, String) onSave,
}) {
  String name = addressName;
  String location = addressLocation;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: 'Address Name',
              initialValue: addressName,
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Address Location',
              initialValue: addressLocation,
              onChanged: (value) => location = value,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.errorColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.lightColor),
            ),
            onPressed: () {
              onSave(name, location);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Dialog for change password
Future<void> showChangePasswordDialog(BuildContext context) {
  String newPassword = '';
  String confirmPassword = '';

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: 'New Password',
              initialValue: '',
              onChanged: (value) => newPassword = value,
              obscureText: true,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Confirm Password',
              initialValue: '',
              onChanged: (value) => confirmPassword = value,
              obscureText: true,
              isRequired: true,
              validator: (value) {
                if (value != newPassword) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text(
              'Change Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.lightColor),
            ),
            onPressed: () {
              if (newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
                if (newPassword == confirmPassword) {
                  logger.i('New Password: $newPassword');
                  Navigator.of(context).pop();
                }
              } 
            },
          ),
        ],
      );
    },
  );
}
