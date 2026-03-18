import 'package:flutter/material.dart';
import 'header.dart';
import 'qr.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({super.key});

  @override
  State<RightPanel> createState() => RightPanelState();
}

class RightPanelState extends State<RightPanel> {
  // bool _isMobileValid = false;
  // bool _isIdentifyValid = false;
  // bool _isConsentChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //header
          const HeaderSection(),
          const SizedBox(height: 6),
          //qr
          const QrSection(),
          const SizedBox(height: 25),

          Placeholder(
            // onValidationChanged: (isValid) {
            //   setState(() {
            //     _isMobileValid = isValid;
            //   });
            // },
          ),

          const SizedBox(height: 20),

          Placeholder(
            // onValidationChanged: (isValid) {
            //   setState(() => _isIdentifyValid = isValid);
            // },
          ),

          const SizedBox(height: 30),

          Placeholder(), //isEnabled: _isMobileValid && _isIdentifyValid

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
