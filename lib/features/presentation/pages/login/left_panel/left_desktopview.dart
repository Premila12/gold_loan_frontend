import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftDesktopView extends StatelessWidget {
  const LeftDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TEXT SECTION WITH PADDING
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply for Gold Loan",
                style: GoogleFonts.inter(
                  color: Color(0xFF174A8E),
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                ),
              ),
              

              Text(
                "Meet your financial needs with loan against gold.",
                style: GoogleFonts.inter(
                  color: Color(0xFF174A8E),
                  fontSize: 20,
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF93DFFC),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xFF174A8E),
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(text: "Preferred by over "),
                      TextSpan(
                        text: "42 lakh customers",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // IMAGE
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/gold.png",
              fit: BoxFit.cover,
              // fit: BoxFit.contain,
              width: double.infinity,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 15, bottom: 20),
          child: Text(
            "© Copyright HDFC Bank Ltd.",
            style: GoogleFonts.inter(color: Color(0xFF4B5563), fontSize: 12),
          ),
        ),
      ],
    );
  }
}
