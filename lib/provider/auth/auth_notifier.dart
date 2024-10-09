import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/config.dart';
import '../../repository/user_repo.dart';
import '../../utils/utils.dart';
import 'auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._userRepository) : super(const AuthState());

  final BaseUserRepository _userRepository;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Registration with email/password
  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(userName);

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save provider type in local settings
      await CurrentProviderSetting().update(providerId: 'password');

      // Sign out after successful sign-up(to email verification)
      await _userRepository.signOut();
    } catch (e) {
      logger.e('⚡ ERROR in signUp: $e');
      rethrow;
    }
  }

  // Sign-in with email/password
  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save provider type in local settings
      await CurrentProviderSetting().update(providerId: 'password');

      // Ensure email is verified
      if (!userCredential.user!.emailVerified) {
        await _userRepository.signOut();
        throw auth.FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before signing in.',
        );
      }
    } catch (e) {
      logger.e('⚡ ERROR in signIn: $e');
      rethrow;
    }
  }

  // Fetch or create user profile in the database
  Future<void> getUserFuture({required String authUserId}) async {
    final user = await _userRepository.getUserFuture(userId: authUserId);

    if (user == null) {
      await _userRepository.create(authUserId);
      final newUser = await _userRepository.getUserFuture(userId: authUserId);
      state = state.copyWith(user: newUser);
    } else {
      await _userRepository.updateProvider(user);
      state = state.copyWith(user: user);
    }
  }

  // google signin
  Future<void> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        await CurrentProviderSetting().update(
          providerId: 'google',
        );
      } else {
        throw auth.FirebaseException(
          plugin: 'firebase_auth',
          code: 'select_one',
        );
      }
    } on auth.FirebaseAuthException catch (e) {
      logger.e('⚡ ERROR: $e');
      rethrow;
    }
  }

// delete account
  Future<String?> deleteAccount(
      {required String? password, required String profileUrl}) async {
    try {
      final currentUser = _auth.currentUser!;
      final providerId = await CurrentProviderSetting().get() ?? '';
      if (profileUrl.isNotEmpty) {
        await _userRepository.deleteFromStorage(profileUrl);
      }
      if (providerId.contains('password')) {
        await currentUser
            .reauthenticateWithCredential(
          auth.EmailAuthProvider.credential(
            email: currentUser.email!,
            password: password!,
          ),
        )
            .then((value) {
          _userRepository.signOut();
          _userRepository.deleteUser(userId: value.user!.uid);
          value.user!.delete();
        });
      } else {
        if (providerId.contains('google')) {
          final provider = auth.GoogleAuthProvider();
          await currentUser.reauthenticateWithProvider(provider).then((value) {
            _userRepository.signOut();
            _userRepository.deleteUser(userId: value.user!.uid);
            value.user!.delete();
          });
        }
      }
      return null;
    } on auth.FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthStateNotifier(userRepository);
});

final authUserStreamProvider = StreamProvider.autoDispose<auth.User?>((ref) {
  return ref.watch(userRepositoryProvider).authUserStream();
});
