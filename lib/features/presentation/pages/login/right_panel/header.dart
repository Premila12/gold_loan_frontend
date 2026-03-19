import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  Future<void> launchHDFCUrl() async {
    final Uri url = Uri.parse(
      'https://applynow.hdfc.bank.in/gold-loan/track-application-login-page',
    );

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Let's Get Started",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        InkWell(
          onTap: launchHDFCUrl,
          child: Row(
            mainAxisSize:
                MainAxisSize.min, 
            children: [
              Text(
                "Track/edit loan application ",
                style: GoogleFonts.inter(
                  color: Color(0xFF1C3FCA),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Color(0xFF1C3FCA),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
