import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// import '../../providers/auth_controller.dart';
// import '../../providers/auth_state.dart';

class QRLoginPopup extends ConsumerStatefulWidget {
  const QRLoginPopup({super.key});

  @override
  ConsumerState<QRLoginPopup> createState() => _QRLoginPopupState();
}

class _QRLoginPopupState extends ConsumerState<QRLoginPopup> {
  int secondsRemaining = 60;
  Timer? timer;
  bool isExpired = false;
 
 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
//   @override
//   void initState() {
//     super.initState();

//       Future.microtask(() {
//     ref.listen<AuthState>(authControllerProvider, (previous, next) {
//       if (next.stage == AuthStage.authenticated) {
//         if (mounted) {
//           Navigator.pop(context);
//           Navigator.pushReplacementNamed(context, "/dashboard");
//         }
//       }
//     });
//   });

//     /// Generate QR after UI loads
//     Future.microtask(() async {
//       await ref.read(authControllerProvider.notifier).generateQr();
//       startTimer();
//     });
//   }

//   void startTimer() {
//     timer?.cancel();

//     secondsRemaining = 60;
//     isExpired = false;

//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (secondsRemaining > 0) {
//         setState(() {
//           secondsRemaining--;
//         });
//       } else {
//         timer.cancel();
//         setState(() {
//           isExpired = true;
//         });
//       }
//     });
//   }

//   String get formattedTime {
//     final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
//     final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Future<void> refreshQr() async {
//     setState(() {
//       isExpired = false;
//     });

//     await ref.read(authControllerProvider.notifier).generateQr();
//     startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// ✅ Reactive state
//     final authState = ref.watch(authControllerProvider);

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Center(
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 450),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFF1C4D7A), Color(0xFF3C78A8)],
//             ),
//           ),
//           child: Stack(
//             children: [
//               /// Close button
//               Positioned(
//                 right: 0,
//                 top: 0,
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.close, color: Colors.white),
//                 ),
//               ),

//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 10),

//                   const Text(
//                     "Scan QR to Login",
//                     style: TextStyle(fontSize: 22, color: Colors.white),
//                   ),

//                   const SizedBox(height: 25),

//                   /// QR Container
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: authState.qrDeepLink == null
//                         ? const SizedBox(
//                             height: 200,
//                             width: 200,
//                             child: Center(child: CircularProgressIndicator()),
//                           )
//                         : Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               /// ✅ QR from deeplink
//                               Opacity(
//                                 opacity: isExpired ? 0.3 : 1,
//                                 child: QrImageView(
//                                   data: authState.qrDeepLink!,
//                                   size: 200,
//                                   version: QrVersions.auto,
//                                 ),
//                               ),

//                               /// Expired overlay
//                               if (isExpired)
//                                 const Text(
//                                   "QR Expired",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                   ),

//                   const SizedBox(height: 25),

//                   /// Timer
//                   Text(
//                     isExpired
//                         ? "QR expired"
//                         : "QR expires in $formattedTime",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   /// Refresh button
//                   ElevatedButton(
//                     onPressed: refreshQr,
//                     child: const Text("Refresh QR"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}