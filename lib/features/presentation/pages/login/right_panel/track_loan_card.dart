import 'package:flutter/material.dart';
import 'package:gold_loan_hdfc/core/constants/link.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackLoanCard extends StatelessWidget {
  const TrackLoanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet, color: Colors.orange),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              "Already applied for a Gold Loan?",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),

          InkWell(
            onTap: AppLinks.openTrackApplication,
            child: Row(
              children: [
                Text(
                  "Track/edit loan application ",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1C3FCA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}