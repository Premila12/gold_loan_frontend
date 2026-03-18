import 'package:flutter/material.dart';
import 'package:design_kit/design_kit/src/QR/qr_action_widget.dart';
import 'package:design_kit/design_kit/src/QR/qr_action_widget_info.dart';

import 'qrpopup.dart';

class QrSection extends StatelessWidget {
  const QrSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade400),
       
      
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QrActionWidget(
            qrActionWidgetInfo: QrActionWidgetInfo(
              icon: Icons.qr_code_scanner,
              // We pass an empty string because the text is handled in the Column below
              // text: "",
              backgroundColor: const Color(0xFFD7F3FF),
              // textColor: const Color(0xFF1C3FCA),
              borderRadius: 50,
              // padding: const EdgeInsets.all(20),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => const QRLoginPopup(),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Click to scan QR and Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "New HDFC Bank Early Access App Required",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),

          // badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, size: 20, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  "NEW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
