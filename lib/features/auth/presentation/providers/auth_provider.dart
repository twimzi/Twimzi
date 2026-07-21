import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(authRepositoryProvider),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(AuthState.initial()) {
    _initialize();
  }

  final AuthRepository _repository;

  StreamSubscription? _subscription;

  void _initialize() {
    if (_repository.isLoggedIn) {
      final user = _repository.currentUser!;

      if (_repository.isEmailVerified) {
        state = AuthState.authenticated(
          userId: user.id,
          email: user.email ?? '',
          displayName: user.userMetadata?['full_name'] as String?,
        );
      } else {
        state = AuthState.emailVerificationPending(
          email: user.email ?? '',
        );
      }
    } else {
      state = AuthState.unauthenticated();
    }

    _subscription = _repository.authStateChanges.listen((event) {
      final user = event.session?.user;

      if (user == null) {
        state = AuthState.unauthenticated();
        return;
      }

      if (_repository.isEmailVerified) {
        state = AuthState.authenticated(
          userId: user.id,
          email: user.email ?? '',
          displayName: user.userMetadata?['full_name'] as String?,
        );
      } else {
        state = AuthState.emailVerificationPending(
          email: user.email ?? '',
        );
      }
    });
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = AuthState.loading();

      await _repository.signIn(
        email: email,
        password: password,
      );

      final user = _repository.currentUser;

      if (user == null) {
        state = AuthState.error('Unable to sign in.');
        return;
      }

      if (_repository.isEmailVerified) {
        state = AuthState.authenticated(
          userId: user.id,
          email: user.email ?? '',
          displayName: user.userMetadata?['full_name'] as String?,
        );
      } else {
        state = AuthState.emailVerificationPending(
          email: user.email ?? '',
        );
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      state = AuthState.loading();

      await _repository.register(
        email: email,
        password: password,
        fullName: fullName,
      );

      state = AuthState.emailVerificationPending(
        email: email,
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> forgotPassword(
      String email,
      ) async {
    try {
      state = AuthState.loading();

      await _repository.sendPasswordResetEmail(
        email: email,
      );

      state = AuthState.passwordResetSent(
        email: email,
      );
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      await _repository.resendVerificationEmail();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      final verified =
      await _repository.checkEmailVerification();

      if (!verified) {
        return false;
      }

      final user = _repository.currentUser;

      if (user == null) {
        return false;
      }

      state = AuthState.authenticated(
        userId: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['full_name'] as String?,
      );

      return true;
    } catch (e) {
      state = AuthState.error(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();

      state = AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  Future<void> changePassword({
    required String newPassword,
  }) async {
    try {
      state = AuthState.loading();

      await _repository.changePassword(
        newPassword: newPassword,
      );

      final user = _repository.currentUser;

      if (user == null) {
        state = AuthState.unauthenticated();
        return;
      }

      state = AuthState.authenticated(
        userId: user.id,
        email: user.email ?? '',
        displayName:
        user.userMetadata?['full_name'] as String?,
      );
    } catch (e) {
      state = AuthState.error(
        e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  Future<void> signInWithGoogle() async {
    try {
      state = AuthState.loading();

      await _repository.signInWithGoogle();

      final user = _repository.currentUser;

      if (user == null) {
        state = AuthState.error(
          'Unable to sign in with Google.',
        );
        return;
      }

      state = AuthState.authenticated(
        userId: user.id,
        email: user.email ?? '',
        displayName:
        user.userMetadata?['full_name'] as String?,
      );
    } catch (e) {
      state = AuthState.error(
        e.toString(),
      );
    }
  }
}
