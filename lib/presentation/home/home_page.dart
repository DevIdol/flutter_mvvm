import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mvvm/provider/user/user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = auth.FirebaseAuth.instance.currentUser;
    final providerData = currentUser?.providerData;
    final userAsyncValue = ref.watch(userProviderStream(userId));
    final providerId = useState<String?>('');

    // Fetch the providerId when the widget builds
    useEffect(() {
      Future<void> fetchProviderId() async {
        providerId.value = await CurrentProviderSetting().get();
      }

      fetchProviderId();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          userAsyncValue.when(
            data: (user) {
              UserProviderData? userProvider;
              if (providerData != null && providerId.value!.isNotEmpty) {
                final userInfo = providerData.firstWhere(
                  (provider) => provider.providerId == providerId.value,
                );
                final providerDataUid = userInfo.uid;
                if (providerDataUid != null && user?.providerData != null) {
                  userProvider = user?.providerData!.firstWhere(
                    (provider) => provider.uid == providerDataUid,
                    orElse: () => const UserProviderData(),
                  );
                }
              }
              return IconButton(
                icon: user?.profile != null && user!.profile!.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user.profile!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50,
                          ),
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : userProvider?.photoUrl != null &&
                            userProvider!.photoUrl.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userProvider.photoUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 50,
                              ),
                              fit: BoxFit.cover,
                              width: 30,
                              height: 30,
                            ),
                          )
                        : const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountInfoPage(userId: userId)),
                  );
                },
              );
            },
            loading: () => const Icon(Icons.account_circle),
            error: (error, stack) => const Icon(Icons.error),
          ),
        ],
      ),
      body: TodoListPage(userId: userId),
    );
  }
}
