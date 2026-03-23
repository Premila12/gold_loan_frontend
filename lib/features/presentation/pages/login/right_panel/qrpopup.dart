import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/app_providers.dart';

class QRLoginPopup extends ConsumerStatefulWidget {
  const QRLoginPopup({super.key});

  @override
  ConsumerState<QRLoginPopup> createState() => _QRLoginPopupState();
}

class _QRLoginPopupState extends ConsumerState<QRLoginPopup> {
  final ValueNotifier<int> _secondsNotifier = ValueNotifier(30);

  Timer? _timer;
  bool _isExpired = false;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();

    /// Initial QR call
    Future.microtask(() {
      final authState = ref.read(authControllerProvider);
      final journeyId = authState.value?.journeyId;

      if (journeyId != null) {
        ref.read(qrControllerProvider.notifier).generateQr(journeyId);
      }
    });
  }

  /// TIMER
  void _startTimer() {
    _timer?.cancel();
    _secondsNotifier.value = 30;

    setState(() {
      _isExpired = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value == 0) {
        timer.cancel();

        setState(() {
          _isExpired = true;
        });
      } else {
        _secondsNotifier.value--;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Listen for QR generation → start timer
    ref.listen(qrControllerProvider, (prev, next) {
      final controller = ref.read(qrControllerProvider.notifier);

      /// CLOSE POPUP WHEN LOGIN SUCCESS
      if (controller.isAuthenticated) {
        Navigator.pop(context);
      }

      /// START TIMER WHEN QR ARRIVES
      next.whenData((data) {
        if (data != null) {
          _startTimer();
        }
      });
    });
    final qrState = ref.watch(qrControllerProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 350,
          child: qrState.when(
            loading: () => const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            ),

            error: (e, _) => const SizedBox(
              height: 300,
              child: Center(child: Text("Error loading QR")),
            ),

            data: (data) {
              if (data == null) {
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// HEADER
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          "Login via QR Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Use your HDFC Early Access App to scan the QR AND log in.\n"
                    "Authenticate will happen via the App.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),

                  const SizedBox(height: 12),

                  /// STORE IMAGES
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/app_store.png", height: 30),
                      const SizedBox(width: 10),
                      Image.asset("assets/images/play_store.png", height: 30),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// QR SECTION
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            /// QR IMAGE
                            Opacity(
                              opacity: _isExpired ? 0.3 : 1,
                              child: Image.memory(
                                base64Decode(data.qrBase64),
                                height: 180,
                                width: 180,
                              ),
                            ),

                            /// BLUR OVERLAY
                            if (_isExpired)
                              Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                            /// REFRESH BUTTON
                            if (_isExpired)
                              ElevatedButton.icon(
                                onPressed: () {
                                  final authState = ref.read(
                                    authControllerProvider,
                                  );
                                  final journeyId = authState.value?.journeyId;

                                  if (journeyId != null) {
                                    ref
                                        .read(qrControllerProvider.notifier)
                                        .generateQr(journeyId);
                                  }
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text("Refresh"),
                              ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// TIMER
                        if (!_isExpired)
                          ValueListenableBuilder<int>(
                            valueListenable: _secondsNotifier,
                            builder: (_, secs, __) {
                              return Text(
                                "Refreshes in $secs secs",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// FOOTER
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Trouble scanning the QR Code?",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
