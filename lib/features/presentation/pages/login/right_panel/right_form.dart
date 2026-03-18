import 'package:flutter/material.dart';
import 'consent.dart';
import 'header.dart';
import 'identify.dart';
import 'mobile.dart';
import 'qr.dart';
import 'amount.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({super.key});

  @override
  State<RightPanel> createState() => RightPanelState();
}

class RightPanelState extends State<RightPanel> {
  // bool _isMobileValid = false;
  // bool _isIdentifyValid = false;
  // bool _isConsentChecked = false;
  bool _isAmountValid = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeaderSection(),
          const SizedBox(height: 6),

          const QrSection(),
          const SizedBox(height: 25),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PhoneSection(onValidationChanged: (bool isValid) {}),
                // onValidationChanged: (isValid) {
                //   setState(() {
                //     _isMobileValid = isValid;
                //   });
                // },
              ),

              const SizedBox(width: 20),

              //identify
              Expanded(
                child: IdentifySection(
                  onValidationChanged: (bool isValid) {
                    // setState(() => _isIdentifyValid = isValid);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          AmountSection(),

          const SizedBox(height: 30),

          ConsentSection(isAmountValid: _isAmountValid),
          const SizedBox(height: 12),

          Placeholder(), //isEnabled: _isMobileValid && _isIdentifyValid

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
