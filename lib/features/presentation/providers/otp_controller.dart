import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/usecases/identify_user_usecase.dart';
import '../../domain/usecases/otp_init_usecase.dart';
import '../../domain/usecases/otp_validate_usecase.dart';

// ─── OTP State (inline, no separate state file) ──────────────────────────────

enum OtpStatus { idle, loading, otpSent, validating, validated, error }

class OtpState {
  final OtpStatus status;
  final String? sessionToken;
  final String? identifyToken;
  final String? errorMessage;
  final int secondsLeft;

  const OtpState({
    this.status = OtpStatus.idle,
    this.sessionToken,
    this.identifyToken,
    this.errorMessage,
    this.secondsLeft = 30,
  });

  OtpState copyWith({
    OtpStatus? status,
    String? sessionToken,
    String? identifyToken,
    String? errorMessage,
    int? secondsLeft,
  }) {
    return OtpState(
      status: status ?? this.status,
      sessionToken: sessionToken ?? this.sessionToken,
      identifyToken: identifyToken ?? this.identifyToken,
      errorMessage: errorMessage ?? this.errorMessage,
      secondsLeft: secondsLeft ?? this.secondsLeft,
    );
  }
}

// ─── OTP Controller ───────────────────────────────────────────────────────────

class OtpController extends StateNotifier<OtpState> {
  final IdentifyUserUseCase identifyUserUseCase;
  final OtpInitUseCase otpInitUseCase;
  final OtpValidateUseCase otpValidateUseCase;

  Timer? _countdownTimer;

  OtpController({
    required this.identifyUserUseCase,
    required this.otpInitUseCase,
    required this.otpValidateUseCase,
  }) : super(const OtpState());

  /// Called when user clicks Login — identifies user then sends OTP
  Future<void> startOtpFlow({
    required String phoneNumber,
    required String pan,
    required String dob,
    required String journeyId,
  }) async {
    state = state.copyWith(status: OtpStatus.loading, errorMessage: null);

    try {
      // Step 1: Identify user
      print("🔐 Starting OTP flow...");
      final identifyResponse = await identifyUserUseCase.call(phoneNumber, pan, dob);

      if (identifyResponse.status == "USER_NOT_FOUND") {
        state = state.copyWith(
          status: OtpStatus.error,
          errorMessage: "User not found. Please check your details.",
        );
        return;
      }

      final identifyToken = identifyResponse.identifyToken!;
      print("✅ User identified. Token: $identifyToken");

      // Step 2: Init OTP
      final otpInitResponse = await otpInitUseCase.call(journeyId, identifyToken);

      print("📲 OTP sent. Session: ${otpInitResponse.sessionToken}");

      state = state.copyWith(
        status: OtpStatus.otpSent,
        sessionToken: otpInitResponse.sessionToken,
        identifyToken: identifyToken,
        secondsLeft: 30,
      );

      _startCountdown();
    } catch (e) {
      print("❌ OTP flow error: $e");
      state = state.copyWith(
        status: OtpStatus.error,
        errorMessage: "Something went wrong. Please try again.",
      );
    }
  }

  /// Called when user submits OTP digits
  Future<void> submitOtp({
    required String otp,
    required String journeyId,
  }) async {
    final sessionToken = state.sessionToken;
    if (sessionToken == null) return;

    state = state.copyWith(status: OtpStatus.validating, errorMessage: null);

    try {
      final response = await otpValidateUseCase.call(sessionToken, journeyId, otp);

      print("🔵 OTP VALIDATE STATUS: ${response.status}");

      if (response.status == "OTP_VALIDATED") {
        _countdownTimer?.cancel();
        state = state.copyWith(status: OtpStatus.validated);
        return;
      }

      String errorMsg;
      switch (response.status) {
        case "INVALID_OTP":
          errorMsg = "Invalid OTP. Please try again.";
          break;
        case "OTP_EXPIRED":
          errorMsg = "OTP has expired. Please resend.";
          break;
        case "MAX_ATTEMPTS_EXCEEDED":
          errorMsg = "Too many attempts. Please request a new OTP.";
          break;
        default:
          errorMsg = "Verification failed. Please try again.";
      }

      state = state.copyWith(status: OtpStatus.otpSent, errorMessage: errorMsg);
    } catch (e) {
      print("❌ OTP submit error: $e");
      state = state.copyWith(
        status: OtpStatus.otpSent,
        errorMessage: "Something went wrong. Please try again.",
      );
    }
  }

  /// Resend OTP — re-calls otpInit with stored identifyToken
  Future<void> resendOtp(String journeyId) async {
    final identifyToken = state.identifyToken;
    if (identifyToken == null) return;

    _countdownTimer?.cancel();
    state = state.copyWith(status: OtpStatus.loading, errorMessage: null);

    try {
      final otpInitResponse = await otpInitUseCase.call(journeyId, identifyToken);

      state = state.copyWith(
        status: OtpStatus.otpSent,
        sessionToken: otpInitResponse.sessionToken,
        secondsLeft: 30,
      );

      _startCountdown();
    } catch (e) {
      state = state.copyWith(
        status: OtpStatus.error,
        errorMessage: "Failed to resend OTP. Please try again.",
      );
    }
  }

  /// Reset state (e.g., when user closes the OTP dialog)
  void reset() {
    _countdownTimer?.cancel();
    state = const OtpState();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft <= 1) {
        timer.cancel();
        state = state.copyWith(secondsLeft: 0);
      } else {
        state = state.copyWith(secondsLeft: state.secondsLeft - 1);
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
