import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _client.auth.resetPasswordForEmail(
      email.trim(),
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<AuthResponse> refreshSession() async {
    final session = _client.auth.currentSession;

    if (session == null) {
      throw const AuthException(
        'No active session found.',
      );
    }

    return await _client.auth.refreshSession();
  }

  bool get isLoggedIn =>
      _client.auth.currentUser != null;
}