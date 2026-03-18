import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftMobileView extends StatelessWidget {
  const LeftMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
      color: const Color(0xFFDDF2F8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Apply for Gold Loan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF174A8E),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Meet your financial needs with loan against gold.",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF174A8E),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF93DFFC),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF174A8E),
                      ),
                      children: const [
                        TextSpan(text: "Preferred by over "),
                        TextSpan(
                          text: "42 lakh customers",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(width: 10),

          /// IMAGE SIDE
          Expanded(
            // flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416),
                child: Image.asset(
                  "assets/images/gold.png",
                  width: 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
