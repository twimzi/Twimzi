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

      state = AuthState.authenticated(
        userId: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['full_name'] as String?,
      );
    } else {
      state = AuthState.unauthenticated();
    }

    _subscription = _repository.authStateChanges.listen((event) {
      final user = event.session?.user;

      if (user == null) {
        state = AuthState.unauthenticated();
        return;
      }

      state = AuthState.authenticated(
        userId: user.id,
        email: user.email ?? '',
        displayName: user.userMetadata?['full_name'] as String?,
      );
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
    } catch (e) {
      state = AuthState.error(
        e.toString(),
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      state = AuthState.loading();

      await _repository.register(
        email: email,
        password: password,
      );
    } catch (e) {
      state = AuthState.error(
        e.toString(),
      );
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
      state = AuthState.error(
        e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();

      state = AuthState.unauthenticated();
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
}