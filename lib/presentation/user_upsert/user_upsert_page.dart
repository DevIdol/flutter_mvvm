import 'package:flutter/material.dart';
import 'package:flutter_mvvm/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../provider/provider.dart';
import '../../utils/utils.dart';
import 'widgets/profile_image.dart';
import 'widgets/save_btn.dart';

class UserUpsertPage extends HookConsumerWidget {
  UserUpsertPage({super.key, required this.user});

  final User? user;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUpsertViewModelState =
        ref.watch(userUpsertViewModelNotifierProvider(user));
    final userUpsertViewModelNotifier =
        ref.watch(userUpsertViewModelNotifierProvider(user).notifier);

    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text(user == null ? Messages.createUser : Messages.updateUser),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileImageSection(
                    state: userUpsertViewModelState,
                    viewModel: userUpsertViewModelNotifier,
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'First Name',
                    initialValue: userUpsertViewModelState.firstName,
                    onChanged: userUpsertViewModelNotifier.setFirstName,
                    isRequired: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Last Name',
                    initialValue: userUpsertViewModelState.lastName,
                    onChanged: userUpsertViewModelNotifier.setLastName,
                    isRequired: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Email',
                    initialValue: userUpsertViewModelState.email,
                    onChanged: userUpsertViewModelNotifier.setEmail,
                    isRequired: true,
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Address Name',
                    initialValue: userUpsertViewModelState.address?.name ?? '',
                    onChanged: userUpsertViewModelNotifier.setAddressName,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Address Location',
                    initialValue:
                        userUpsertViewModelState.address?.location ?? '',
                    onChanged: userUpsertViewModelNotifier.setAddressLocation,
                  ),
                  const SizedBox(height: 40),
                  SaveButton(
                    userUpsertViewModelNotifier: userUpsertViewModelNotifier,
                    context: context,
                    formKey: _formKey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
