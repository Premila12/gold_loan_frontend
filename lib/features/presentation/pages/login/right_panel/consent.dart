import 'package:design_kit/design_kit/src/checkbox/checkbox.dart';
import 'package:design_kit/design_kit/src/checkbox/checkbox_info.dart';
import 'package:design_kit/design_kit/src/primary_button/button_widget.dart';
import 'package:design_kit/design_kit/src/primary_button/button_widget_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';



class ConsentSection extends StatefulWidget {
  final bool isAmountValid;

  const ConsentSection({super.key, required this.isAmountValid});

  @override
  State<ConsentSection> createState() => _ConsentSectionState();
}

class _ConsentSectionState extends State<ConsentSection> {
  bool _consent1 = false;
  bool _consent2 = false;

  /// ✅ Button enable logic
  bool get _isButtonEnabled => widget.isAmountValid && _consent1;

  Future<void> privacyLink() async {
    final Uri url = Uri.parse(
      "https://www.hdfc.bank.in/privacy-policy",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }
   Future<void> tandcLink() async {
    final Uri url = Uri.parse(
      "https://www.hdfc.bank.in/terms-and-conditions",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }
  Future<void> noticeLink() async {
    final Uri url = Uri.parse(
      "https://www.hdfc.bank.in/smartwealth/consent",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

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
              setState(() => _consent1 = value ?? false);
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
                  ..onTap = noticeLink,
              ),

              const TextSpan(text: " (Mandatory Consent)."),
            ],

            fontSize: 13,
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
                  ..onTap = noticeLink,
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
                style: GoogleFonts.inter(color: Colors.blue,),
                recognizer: TapGestureRecognizer()
                  ..onTap = tandcLink,
              ),

              const TextSpan(text: " and "),

              TextSpan(
                text: "Privacy Policy",
                style: GoogleFonts.inter(color: Colors.blue,),
                recognizer: TapGestureRecognizer()
                  ..onTap = privacyLink,
              ),

              const TextSpan(text: "."),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // LOGIN BUTTON
        ButtonWidget(
          buttonWidgetInfo: ButtonWidgetInfo(
            buttonText: "Login",
            height: 50,
            width: 200,
            

            backgroundColor:
                _isButtonEnabled ? Colors.blue : Colors.grey.shade400,

            textColor: Colors.white,

            onPressed: _isButtonEnabled
                ? () {
                    print("Login Clicked ✅");
                  }
                : null,
          ),
        ),
      ],
    );
  }
}