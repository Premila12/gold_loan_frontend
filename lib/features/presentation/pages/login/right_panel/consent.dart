import 'package:design_kit/design_kit/src/checkbox/checkbox.dart';
import 'package:design_kit/design_kit/src/checkbox/checkbox_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/link.dart';

class ConsentSection extends StatefulWidget {
  final ValueChanged<bool> onConsentChanged;

  const ConsentSection({super.key, required this.onConsentChanged});

  @override
  State<ConsentSection> createState() => _ConsentSectionState();
}

class _ConsentSectionState extends State<ConsentSection> {
  bool _consent1 = false;
  bool _consent2 = false;

  // /// Button enable logic
  // bool get _isButtonEnabled => widget.isAmountValid && _consent1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 CONSENT 1 (MANDATORY)
        CustomCheckbox(
          info: CheckboxInfo(
            value: _consent1,
            onChanged: (value) {
              final newValue = value ?? false;
              setState(() => _consent1 = newValue);

              /// 🔥 SEND TO PARENT
              widget.onConsentChanged(newValue);
            },

            textSpans: [
              const TextSpan(
                text:
                    "I hereby consent to collection and processing of my data for availing this Loan and related Services in a manner described in the ",
              ),

              TextSpan(
                text: "Notice",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = AppLinks.openNoticeConsent,
              ),

              const TextSpan(text: " (Mandatory Consent)."),
            ],

            fontSize: 15,
            lineHeight: 1.4,
            spacing: 8,
            checkboxSize: 20,
          ),
        ),

        const SizedBox(height: 10),

        // CONSENT 2 (OPTIONAL)
        CustomCheckbox(
          info: CheckboxInfo(
            value: _consent2,
            onChanged: (value) {
              setState(() => _consent2 = value ?? false);
            },

            textSpans: [
              const TextSpan(
                text:
                    "I hereby consent to processing of my data for sending me personalized offers on other product and services of HDFC Bank, its affiliates and partners through call, SMS, WhatsApp, email or other channels in the manner described in the ",
              ),

              TextSpan(
                text: "Notice",
                style: GoogleFonts.inter(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = AppLinks.openNoticeConsent,
              ),

              const TextSpan(text: "."),
            ],

            fontSize: 15,
            lineHeight: 1.4,
            spacing: 8,
            checkboxSize: 20,
          ),
        ),

        const SizedBox(height: 12),

        // TERMS & PRIVACY
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 15,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: "For full details read our "),

              TextSpan(
                text: "Terms & Conditions",
                style: GoogleFonts.inter(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = AppLinks.openTermsAndConditions,
              ),

              const TextSpan(text: " and "),

              TextSpan(
                text: "Privacy Policy",
                style: GoogleFonts.inter(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = AppLinks.openPrivacyPolicy,
              ),

              const TextSpan(text: "."),
            ],
          ),
        ),

        const SizedBox(height: 20),

  
      ],
    );
  }
}
