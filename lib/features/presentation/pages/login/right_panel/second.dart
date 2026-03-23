// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:qr_flutter/qr_flutter.dart';
// // import 'dart:ui';
// // import '../qr_help_video_dialog.dart';
// // import 'package:loan_against_security/core/services/auth_api_service.dart';
// // import 'package:loan_against_security/features/loan_against_securities/presentaion/pages/dashboard_page.dart';

// // class QrPopupDialog extends StatefulWidget {
// //   final String journeyId;
// //   final String journeyName;

// //   const QrPopupDialog({
// //     super.key,
// //     required this.journeyId,
// //     required this.journeyName,
// //   });

// //   @override
// //   State<QrPopupDialog> createState() => _QrPopupDialogState();
// // }

// // class _QrPopupDialogState extends State<QrPopupDialog> {
// //   final ValueNotifier<int> _secondsNotifier = ValueNotifier<int>(30);
// //   bool _isExpired = false;
// //   bool _isLoading = true;
// //   String? _errorText;

// //   /// Base64-encoded QR image returned by the backend (optional).
// //   String? _qrImageBase64;

// //   /// Deep-link URL to encode into the QR if no image is returned.
// //   String? _deepLink;

// //   /// Token used for polling.
// //   String? _qrToken;

// //   Timer? _pollTimer;
// //   Timer? _countdownTimer;

// //   static const int _pollIntervalSec = 3;
// //   static const int _maxPolls = 10; // 30s / 3s

// //   @override
// //   void initState() {
// //     super.initState();
// //     _generateQr();
// //   }

// //   @override
// //   void dispose() {
// //     _pollTimer?.cancel();
// //     _countdownTimer?.cancel();
// //     _secondsNotifier.dispose();
// //     super.dispose();
// //   }

// //   // ── Step 1: generate QR ───────────────────────────────────────────────────

// //   Future<void> _generateQr() async {
// //     setState(() {
// //       _isLoading = true;
// //       _isExpired = false;
// //       _errorText = null;
// //       _secondsNotifier.value = 30;
// //     });

// //     try {
// //       final res = await AuthApiService.qrGenerate(
// //         journeyId: widget.journeyId,
// //         journeyName: widget.journeyName,
// //       );

// //       if (!mounted) return;

// //       // Backend returns { data: { qrId, journeyId, ... }, qrBase64: "..." }
// //       final data = res['data'] as Map<String, dynamic>?;
// //       final qrBase64 = res['qrBase64'] as String?;

// //       if (data != null && qrBase64 != null) {
// //         _qrToken = data['qrId'] as String?;
// //         _qrImageBase64 = qrBase64;
// //         // Also store the deepLink for styled QR rendering
// //         _deepLink =
// //             'http://localhost:8080/api/v1/auth/qr/scan'
// //             '?qrId=${_qrToken}'
// //             '&journeyId=${data['journeyId']}'
// //             '&journeyName=${Uri.encodeComponent(data['journeyName'] ?? 'LAS')}';
// //         setState(() => _isLoading = false);
// //         _startCountdown();
// //         _startPolling();
// //       } else {
// //         setState(() {
// //           _isLoading = false;
// //           _errorText = 'Failed to generate QR. Please try again.';
// //         });
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         setState(() {
// //           _isLoading = false;
// //           _errorText = 'Network error generating QR. Please try again.';
// //         });
// //       }
// //     }
// //   }

// //   // ── Countdown timer ───────────────────────────────────────────────────────

// //   void _startCountdown() {
// //     _countdownTimer?.cancel();
// //     _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
// //       if (!mounted) return;
// //       if (_secondsNotifier.value > 0) {
// //         _secondsNotifier.value--; // only updates countdown, not QR image
// //       } else {
// //         _countdownTimer?.cancel();
// //         _pollTimer?.cancel();
// //         setState(() => _isExpired = true); // only rebuilds when truly expired
// //       }
// //     });
// //   }

// //   // ── Step 2: poll for approval ─────────────────────────────────────────────

// //   void _startPolling() {
// //     _pollTimer?.cancel();
// //     _pollTimer = Timer.periodic(
// //       const Duration(seconds: _pollIntervalSec),
// //       (_) => _pollQr(),
// //     );
// //   }

// //   Future<void> _pollQr() async {
// //     if (_qrToken == null) return;

// //     try {
// //       // Poll session/fetch which returns PENDING | APPROVED | REJECTED | EXPIRED
// //       final res = await AuthApiService.qrSessionFetch(
// //         qrId: _qrToken!,
// //         journeyId: widget.journeyId,
// //       );

// //       if (!mounted) return;

// //       final status = res['status'] as String?;
// //       switch (status) {
// //         case 'APPROVED':
// //           _pollTimer?.cancel();
// //           _countdownTimer?.cancel();
// //           // Fetch user details using the JWT returned
// //           final jwt = res['token'] as String? ?? '';
// //           String userName = 'Customer';
// //           String customerId = '';
// //           if (jwt.isNotEmpty) {
// //             try {
// //               final userRes = await AuthApiService.fetchUserDetails(jwt);
// //               userName = userRes['name'] as String? ?? 'Customer';
// //               customerId = userRes['customerId']?.toString() ?? '';
// //             } catch (_) {}
// //           }
// //           if (!mounted) return;
// //           Navigator.of(context).pushAndRemoveUntil(
// //             MaterialPageRoute(
// //               builder: (_) =>
// //                   DashboardPage(userName: userName, customerId: customerId),
// //             ),
// //             (route) => false,
// //           );
// //           break;

// //         case 'REJECTED':
// //           _pollTimer?.cancel();
// //           setState(() {
// //             _isExpired = true;
// //             _errorText = 'QR login was denied by the mobile app.';
// //           });
// //           break;

// //         case 'EXPIRED':
// //           _pollTimer?.cancel();
// //           setState(() => _isExpired = true);
// //           break;

// //         case 'PENDING':
// //           break; // keep polling

// //         case 'PENDING':
// //         default:
// //           break;
// //       }
// //     } catch (_) {
// //       // Ignore transient errors during polling
// //     }
// //   }

// //   void _refresh() {
// //     _pollTimer?.cancel();
// //     _countdownTimer?.cancel();
// //     _generateQr();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //       backgroundColor: Colors.white,
// //       child: SizedBox(
// //         width: 460,
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(24),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               // ── Close button ──────────────────────────────
// //               Align(
// //                 alignment: Alignment.topRight,
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     _pollTimer?.cancel();
// //                     _countdownTimer?.cancel();
// //                     Navigator.pop(context);
// //                   },
// //                   child: const Icon(
// //                     Icons.close,
// //                     size: 22,
// //                     color: Colors.black54,
// //                   ),
// //                 ),
// //               ),

// //               // ── Title ─────────────────────────────────────
// //               const Text(
// //                 'Login via QR Code',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.w700,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),

// //               // ── Description ───────────────────────────────
// //               const Text(
// //                 'Use your HDFC Bank Early Access to scan the QR and log in. Authentication will happen via your app, not your Customer ID.',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.black54,
// //                   height: 1.5,
// //                 ),
// //               ),
// //               const SizedBox(height: 24),

// //               // ── App Store + Play Store buttons ────────────
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {},
// //                     child: Image.asset(
// //                       'assets/images/appstore.png',
// //                       height: 44,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 16),
// //                   GestureDetector(
// //                     onTap: () {},
// //                     child: Image.asset(
// //                       'assets/images/googleplay.png',
// //                       height: 44,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 24),

// //               // ── QR Code area ──────────────────────────────
// //               Container(
// //                 padding: const EdgeInsets.all(12),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFFF0F2F5),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: _buildQrArea(),
// //               ),
// //               const SizedBox(height: 12),

// //               // ── Error text ────────────────────────────────
// //               if (_errorText != null)
// //                 Padding(
// //                   padding: const EdgeInsets.only(bottom: 8),
// //                   child: Text(
// //                     _errorText!,
// //                     style: const TextStyle(color: Colors.red, fontSize: 12),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),

// //               // ── Countdown ─────────────────────────────────
// //               if (!_isExpired && !_isLoading)
// //                 ValueListenableBuilder<int>(
// //                   valueListenable: _secondsNotifier,
// //                   builder: (_, secs, __) => Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       const Icon(
// //                         Icons.access_time,
// //                         size: 16,
// //                         color: Colors.black45,
// //                       ),
// //                       const SizedBox(width: 4),
// //                       const Text(
// //                         'Refreshes in ',
// //                         style: TextStyle(fontSize: 13, color: Colors.black45),
// //                       ),
// //                       Text(
// //                         '$secs secs',
// //                         style: const TextStyle(
// //                           fontSize: 13,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               const SizedBox(height: 16),

// //               // ── Trouble scanning link ─────────────────────
// //               GestureDetector(
// //                 onTap: () {
// //                   showDialog(
// //                     context: context,
// //                     builder: (context) => const QrHelpVideoDialog(),
// //                   );
// //                 },
// //                 child: const Text(
// //                   'Trouble scanning the QR Code?',
// //                   style: TextStyle(
// //                     fontSize: 13,
// //                     color: Color(0xFF0055CC),
// //                     decoration: TextDecoration.underline,
// //                     decorationColor: Color(0xFF0055CC),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildQrArea() {
// //     if (_isLoading) {
// //       return const SizedBox(
// //         width: 280,
// //         height: 280,
// //         child: Center(child: CircularProgressIndicator()),
// //       );
// //     }

// //     // Build styled QR using qr_flutter with HDFC blue theme
// //     final qrData = _deepLink ?? _qrToken ?? 'INVALID';
// //     Widget qrImage = QrImageView(
// //       data: qrData,
// //       version: QrVersions.auto,
// //       size: 280,
// //       backgroundColor: Colors.white,
// //       eyeStyle: const QrEyeStyle(
// //         eyeShape: QrEyeShape.square,
// //         color: Color(0xFF003399), // HDFC blue for eyes
// //       ),
// //       dataModuleStyle: const QrDataModuleStyle(
// //         dataModuleShape: QrDataModuleShape.square,
// //         color: Color(0xFF003399), // HDFC blue for data modules
// //       ),
// //       embeddedImage: const AssetImage('assets/images/hdfc.png'),
// //       embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(48, 48)),
// //     );

// //     return Stack(
// //       alignment: Alignment.center,
// //       children: [
// //         ImageFiltered(
// //           imageFilter: ImageFilter.blur(
// //             sigmaX: _isExpired ? 6 : 0,
// //             sigmaY: _isExpired ? 6 : 0,
// //           ),
// //           child: qrImage,
// //         ),
// //         if (_isExpired)
// //           ElevatedButton.icon(
// //             onPressed: _refresh,
// //             icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
// //             label: const Text(
// //               'Refresh',
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: 15,
// //               ),
// //             ),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color(0xFF1A3AA8),
// //               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../providers/app_providers.dart';

// class QRLoginPopup extends ConsumerStatefulWidget {
//   const QRLoginPopup({super.key});

//   @override
//   ConsumerState<QRLoginPopup> createState() => _QRLoginPopupState();
// }

// class _QRLoginPopupState extends ConsumerState<QRLoginPopup> {
//   final ValueNotifier<int> _secondsNotifier = ValueNotifier(30);

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       print("QR POPUP OPENED");

//       final authState = ref.read(authControllerProvider);
//       final journeyId = authState.value?.journeyId;

//       if (journeyId == null) {
//         print(" JourneyId is NULL");
//         return;
//       }

//       ref.read(qrControllerProvider.notifier).generateQr(journeyId);
//     });
//   }

//   /// TIMER FUNCTION
//   void _startTimer(int seconds) {
//     _timer?.cancel();
//     _secondsNotifier.value = seconds;

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsNotifier.value == 0) {
//         timer.cancel();

//         final authState = ref.read(authControllerProvider);
//         final journeyId = authState.value?.journeyId;

//         if (journeyId != null) {
//           ref.read(qrControllerProvider.notifier).generateQr(journeyId);
//         }

//         _timerStarted = false;
//       } else {
//         _secondsNotifier.value--;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final qrState = ref.watch(qrControllerProvider);

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SizedBox(
//           width: 350,
//           child: qrState.when(
//             loading: () => const SizedBox(
//               height: 300,
//               child: Center(child: CircularProgressIndicator()),
//             ),

//             error: (e, _) => const SizedBox(
//               height: 300,
//               child: Center(child: Text("Error loading QR")),
//             ),

//             data: (data) {
//               if (data == null) {
//                 return const SizedBox(
//                   height: 300,
//                   child: Center(child: Text("No QR data")),
//                 );
//               }

//               /// START TIMER ONLY ONCE
//               ref.listen(qrControllerProvider, (prev, next) {
//                 next.whenData((data) {
//                   if (data != null) {
//                     _startTimer(30);
//                   }
//                 });
//               });

//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   /// HEADER
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       const Center(
//                         child: Text(
//                           "Login via QR Code",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: 0,
//                         child: IconButton(
//                           icon: const Icon(Icons.close),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 8),

//                   /// DESCRIPTION
//                   const Text(
//                     "Use your HDFC Early Access App to scan the QR AND log in.\n"
//                     "Authenticate will happen via the App, not your NetBanking Customer ID.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),

//                   const SizedBox(height: 12),

//                   /// STORE IMAGES
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset("assets/images/app_store.png", height: 30),
//                       const SizedBox(width: 10),
//                       Image.asset("assets/images/play_store.png", height: 30),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   /// QR CONTAINER
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEFF3F6),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       children: [
//                         Image.memory(
//                           base64Decode(data.qrBase64),
//                           height: 180,
//                           width: 180,
//                         ),

//                         const SizedBox(height: 10),

//                         ValueListenableBuilder<int>(
//                           valueListenable: _secondsNotifier,
//                           builder: (_, secs, __) {
//                             return Text(
//                               "Refreshes in $secs secs",
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   /// REFRESH BUTTON
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       final authState = ref.read(authControllerProvider);
//                       final journeyId = authState.value?.journeyId;

//                       if (journeyId != null) {
//                         ref
//                             .read(qrControllerProvider.notifier)
//                             .generateQr(journeyId);

//                         /// restart timer manually
//                         _timerStarted = false;
//                       }
//                     },
//                     icon: const Icon(Icons.refresh),
//                     label: const Text("Refresh"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade800,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   /// FOOTER
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Trouble scanning the QR Code?",
//                       style: GoogleFonts.inter(
//                         fontSize: 12,
//                         color: Colors.blueAccent,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
