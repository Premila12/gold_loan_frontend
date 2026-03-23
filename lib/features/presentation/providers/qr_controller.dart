import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/usecases/fetch_session_usecase.dart';
import '../../domain/usecases/generate_qr_usecase.dart';
import '../../data/models/response.dart';

class QrController extends StateNotifier<AsyncValue<GenerateQrResponse?>> {
  final GenerateQrUseCase generateQrUseCase;
  final SessionFetchUseCase sessionFetchUseCase;

  Timer? _pollingTimer;
  bool isAuthenticated = false;

  QrController(
    this.generateQrUseCase,
    this.sessionFetchUseCase,
  ) : super(const AsyncData(null));

  // Generate QR
  Future<void> generateQr(String journeyId) async {
    try {
      state = const AsyncLoading();

      final response = await generateQrUseCase.call(journeyId);

      print("QR ID: ${response.qrId}");

      state = AsyncData(response);

      // Start polling AFTER QR is generated
      _startPolling(
        qrId: response.qrId,
        journeyId: journeyId,
      );
    } catch (e) {
      print("QR ERROR: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }

  // POLLING FUNCTION
  void _startPolling({
    required String qrId,
    required String journeyId,
  }) {
    print("Start polling...");

    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final response =
            await sessionFetchUseCase.call(qrId, journeyId);

        print(" Status: ${response.status}");

        /// WAITING
        if (response.status == "PENDING") {
          return;
        }

        /// SUCCESS
        if (response.status == "APPROVED") {
          print(" LOGIN SUCCESS: ${response.token}");

          timer.cancel();

          // You can trigger navigation later
          return;
        }

        //REJECTED
        if (response.status == "REJECTED") {
          print(" Login Rejected");
          timer.cancel();
          return;
        }

        /// EXPIRED
        if (response.status == "EXPIRED") {
          print("QR Expired");
          timer.cancel();
          return;
        }
      } catch (e) {
        print("POLLING ERROR: $e");
      }
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }
}
