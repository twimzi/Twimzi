import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  bool get isLoggedIn =>
      _client.auth.currentUser != null;

  bool get isEmailVerified =>
      _client.auth.currentUser?.emailConfirmedAt != null;

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
    String? fullName,
  }) async {
    return await _client.auth.signUp(
      email: email.trim(),
      password: password,
      data: {
        'full_name': fullName,
      },
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _client.auth.resetPasswordForEmail(
      email.trim(),
    );
  }

  Future<void> resendVerificationEmail() async {
    final user = currentUser;

    if (user == null) {
      throw const AuthException(
        'No authenticated user found.',
      );
    }

    await _client.auth.resend(
      type: OtpType.signup,
      email: user.email!,
    );
  }

  Future<void> refreshCurrentUser() async {
    await _client.auth.refreshSession();
  }

  Future<bool> checkEmailVerification() async {
    await refreshCurrentUser();

    return isEmailVerified;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
    Future<UserResponse> changePassword({
    required String newPassword,
  }) async {
    return await _client.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );
  }
  Future<AuthResponse> signInWithGoogle() async {
    await _googleSignIn.initialize(
      serverClientId:
      '1097004014699-fq94d759sok1qb04f2rfrbosgo9ekg5p.apps.googleusercontent.com',
    );

    final GoogleSignInAccount account =
    await _googleSignIn.authenticate();

    final GoogleSignInAuthentication authentication =
        account.authentication;

    final idToken = authentication.idToken;

    if (idToken == null) {
      throw const AuthException(
        'Google ID Token not found.',
      );
    }

    return await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: null,
    );
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
}