import 'package:flutter/material.dart';
import 'package:gold_loan_hdfc/core/constants/link.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/responsive.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  Widget _title() {
    return const Text(
      "Let's Get Started",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _actionLink() {
    return InkWell(
      onTap: AppLinks.openTrackApplication,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Track/edit loan application",
            style: GoogleFonts.inter(
              color: const Color(0xFF1C3FCA),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: Color(0xFF1C3FCA),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_title(), const SizedBox(height: 8), _actionLink()],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_title(), _actionLink()],
          );
  }
}
