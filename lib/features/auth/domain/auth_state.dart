enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  emailVerificationPending,
  passwordResetSent,
  error,
}

class AuthState {
  final AuthStatus status;

  final String? userId;
  final String? email;
  final String? displayName;

  final String? errorMessage;

  final bool isLoading;

  const AuthState({
    this.status = AuthStatus.initial,
    this.userId,
    this.email,
    this.displayName,
    this.errorMessage,
    this.isLoading = false,
  });

  bool get isAuthenticated =>
      status == AuthStatus.authenticated;

  bool get isUnauthenticated =>
      status == AuthStatus.unauthenticated;

  bool get hasError =>
      status == AuthStatus.error;

  AuthState copyWith({
    AuthStatus? status,
    String? userId,
    String? email,
    String? displayName,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.initial,
    );
  }

  factory AuthState.loading() {
    return const AuthState(
      status: AuthStatus.loading,
      isLoading: true,
    );
  }

  factory AuthState.authenticated({
    required String userId,
    required String email,
    String? displayName,
  }) {
    return AuthState(
      status: AuthStatus.authenticated,
      userId: userId,
      email: email,
      displayName: displayName,
    );
  }

  factory AuthState.unauthenticated() {
    return const AuthState(
      status: AuthStatus.unauthenticated,
    );
  }

  factory AuthState.emailVerificationPending({
    required String email,
  }) {
    return AuthState(
      status: AuthStatus.emailVerificationPending,
      email: email,
    );
  }

  factory AuthState.passwordResetSent({
    required String email,
  }) {
    return AuthState(
      status: AuthStatus.passwordResetSent,
      email: email,
    );
  }

  factory AuthState.error(
      String message,
      ) {
    return AuthState(
      status: AuthStatus.error,
      errorMessage: message,
    );
  }
}