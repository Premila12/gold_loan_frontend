import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/response.dart';
import '../../domain/usecases/autth_init_usecase.dart';


class AuthController extends StateNotifier<AsyncValue<AuthInitResponse?>> {
  final AuthInitUseCase authInitUseCase;

  AuthController(this.authInitUseCase)
      : super(const AsyncData(null));

  Future<void> initAuth() async {
    print(" initAuth started");

    try {
      state = const AsyncLoading();

      final response = await authInitUseCase.call();

      print("Journey ID: ${response.journeyId}");

   
      // You will need it later for OTP, QR, etc.

      state = AsyncData(response);
    } catch (e) {
      print("ERROR: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }
}














// final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
//   (ref) => AuthController(
//     ref.read(authInitUseCaseProvider),
//     ref.read(generateQrUseCaseProvider),
//     ref.read(fetchSessionUseCaseProvider),
//   ),
// );

// class AuthController extends StateNotifier<AuthState> {
//   final AuthInitUseCase authInitUseCase;
//   final GenerateQrUseCase generateQrUseCase;
//   final FetchSessionUseCase fetchSessionUseCase;

//   Timer? _pollTimer;

//   AuthController(
//     this.authInitUseCase,
//     this.generateQrUseCase,
//     this.fetchSessionUseCase,
//   ) : super(const AuthState());

//   /// ✅ AUTH INIT
//   Future<void> initAuth() async {
//     state = state.copyWith(stage: AuthStage.initializing);

//     try {
//       final AuthInitResponse data = await authInitUseCase.call();

//       // ✅ Direct access (NO Map)
//       final token = data.accessToken;

//       state = state.copyWith(stage: AuthStage.idle, accessToken: token);
//     } catch (e) {
//       state = state.copyWith(
//         stage: AuthStage.error,
//         error: "Network error occurred",
//       );
//     }
//   }

//   /// ✅ GENERATE QR
//   Future<void> generateQr() async {
//     try {
//       final token = state.accessToken;
//       if (token == null) return;

//       final QrResponse response = await generateQrUseCase.call(token);

//       final qrId = response.qrId;
//       final qrImage = response.qrImage;

//       state = state.copyWith(qrId: qrId, qrDeepLink: qrImage);

//       print("QR VALUE: ${response.qrImage}");

//       startPolling(qrId);
//     } catch (e) {
//       state = state.copyWith(
//         stage: AuthStage.error,
//         error: "QR generation failed",
//       );
//     }
//   }

//   /// ✅ START SESSION POLLING
//   void startPolling(String qrId) {
//     _pollTimer?.cancel();

//     _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
//       try {
//         final token = state.accessToken;
//         if (token == null) return;

//         final SessionResponse response = await fetchSessionUseCase.call(
//           token,
//           qrId,
//         );

//         final status = response.status;

//         if (status == "APPROVED") {
//           timer.cancel();
//           state = state.copyWith(stage: AuthStage.authenticated);
//         }

//         if (status == "EXPIRED") {
//           timer.cancel();
//         }
//       } catch (e) {
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _pollTimer?.cancel();
//     super.dispose();
//   }
// }
