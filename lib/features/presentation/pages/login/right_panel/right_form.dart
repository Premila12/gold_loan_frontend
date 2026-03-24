import 'package:flutter/material.dart';
import 'button.dart';
import 'consent.dart';
import 'header.dart';
import 'identify.dart';
import 'mobile.dart';
import 'qr.dart';
import 'amount.dart';
import 'stepcard.dart';
import '../../../../../utils/responsive.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({super.key});

  @override
  State<RightPanel> createState() => RightPanelState();
}

class RightPanelState extends State<RightPanel> {
  // Validation flags
  bool _isMobileValid = false;
  bool _isIdentifyValid = false;
  bool _isAmountValid = false;
  bool _isConsentChecked = false;

  // Actual form values
  String _phoneNumber = '';
  String _identifyValue = ''; // DOB or PAN depending on selection

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

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
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PhoneSection(
                        onValidationChanged: (bool isValid) {
                          setState(() => _isMobileValid = isValid);
                        },
                        onValueChanged: (value) {
                          setState(() => _phoneNumber = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: IdentifySection(
                        onValidationChanged: (bool isValid) {
                          setState(() => _isIdentifyValid = isValid);
                        },
                        onValueChanged: (value) {
                          setState(() => _identifyValue = value);
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PhoneSection(
                      onValidationChanged: (bool isValid) {
                        setState(() => _isMobileValid = isValid);
                      },
                      onValueChanged: (value) {
                        setState(() => _phoneNumber = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    IdentifySection(
                      onValidationChanged: (bool isValid) {
                        setState(() => _isIdentifyValid = isValid);
                      },
                      onValueChanged: (value) {
                        setState(() => _identifyValue = value);
                      },
                    ),
                  ],
                ),

          const SizedBox(height: 20),
          AmountSection(
            onValidationChanged: (bool isValid) {
              setState(() => _isAmountValid = isValid);
            },
          ),
          const SizedBox(height: 30),
          ConsentSection(
            onConsentChanged: (value) {
              setState(() => _isConsentChecked = value);
            },
          ),
          const SizedBox(height: 12),
          ButtonSection(
            isMobileValid: _isMobileValid,
            isIdentifyValid: _isIdentifyValid,
            isAmountValid: _isAmountValid,
            isConsentChecked: _isConsentChecked,
            phoneNumber: _phoneNumber,
            identifyValue: _identifyValue,
          ),

          const SizedBox(height: 12),
          StepsAndLinksSection(),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
