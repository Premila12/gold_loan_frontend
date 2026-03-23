enum AuthStage {
  initializing,
  idle,
  authenticated,
  error,
}

class AuthState {
  final AuthStage stage;
  final String? accessToken;
  final String? qrDeepLink;
  final String? qrId;
  final String? expiresAt;
  final String? error;

  const AuthState({
    this.stage = AuthStage.idle,
    this.accessToken,
    this.qrDeepLink,
    this.qrId,
    this.expiresAt,
    this.error,
  });

  AuthState copyWith({
    AuthStage? stage,
    String? accessToken,
    String? qrDeepLink,
    String? qrId,
    String? expiresAt,
    String? error,
  }) {
    return AuthState(
      stage: stage ?? this.stage,
      accessToken: accessToken ?? this.accessToken,
      qrDeepLink: qrDeepLink ?? this.qrDeepLink,
      qrId: qrId ?? this.qrId,
      expiresAt: expiresAt ?? this.expiresAt,
      error: error ?? this.error,
    );
  }
}