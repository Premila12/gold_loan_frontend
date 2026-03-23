// enum AuthStage {
//   initializing,
//   idle,
//   qrGenerated,
//   authenticated,
//   error,
// }

// class AuthState {
//   final AuthStage stage;

//   final String? accessToken;

//   // QR related
//   final String? qrId;
//   final String? qrBase64;
//   final String? expiresAt;

//   // Polling status
//   final String? qrStatus; // PENDING, APPROVED, etc

//   final String? error;

//   const AuthState({
//     this.stage = AuthStage.idle,
//     this.accessToken,
//     this.qrId,
//     this.qrBase64,
//     this.expiresAt,
//     this.qrStatus,
//     this.error,
//   });

//   AuthState copyWith({
//     AuthStage? stage,
//     String? accessToken,
//     String? qrId,
//     String? qrBase64,
//     String? expiresAt,
//     String? qrStatus,
//     String? error,
//   }) {
//     return AuthState(
//       stage: stage ?? this.stage,
//       accessToken: accessToken ?? this.accessToken,
//       qrId: qrId ?? this.qrId,
//       qrBase64: qrBase64 ?? this.qrBase64,
//       expiresAt: expiresAt ?? this.expiresAt,
//       qrStatus: qrStatus ?? this.qrStatus,
//       error: error ?? this.error,
//     );
//   }
// }