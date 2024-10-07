import 'package:firebase_auth/firebase_auth.dart' as auth;
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

      // Update user display name
      await _updateUserProfile(
        userCredential.user!,
        displayName: userName,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save provider type in local settings
      await CurrentProviderSetting().update(providerId: 'password');

      // Sign out after successful sign-up(to email verification)
      await signOut();
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
        await signOut();
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
  Future<void> getUser({required String authUserId}) async {
    final user = await _userRepository.getUser(userId: authUserId);
    if (user == null) {
      await _userRepository.create(authUserId);
      final newUser = await _userRepository.getUser(userId: authUserId);
      state = state.copyWith(user: newUser);
    } else {
      await _userRepository.updateProvider(user);
      state = state.copyWith(user: user);
    }
  }

  // Sign out user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      logger.e('⚡ ERROR in signOut: $e');
      rethrow;
    }
  }

  // Update user profile
  Future<void> _updateUserProfile(auth.User user, {String? displayName}) async {
    try {
      await user.updateDisplayName(displayName);
    } catch (e) {
      logger.e('⚡ ERROR in _updateUserProfile: $e');
      rethrow;
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
