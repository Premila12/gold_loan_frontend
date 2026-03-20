import 'package:flutter/material.dart';
import 'package:gold_loan_hdfc/features/presentation/pages/login/right_panel/track_loan_card.dart';
import 'package:gold_loan_hdfc/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/link.dart';

class StepsAndLinksSection extends StatelessWidget {
  const StepsAndLinksSection({super.key});

  Widget _verticalDivider() {
    return Container(
      height: 16,
      width: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F0FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Steps to Follow",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _StepItem(
                          icon: Icons.qr_code,
                          label: "Scan QR to Login",
                          isVertical: true,
                        ),
                        SizedBox(height: 16),
                        _StepItem(
                          icon: Icons.verified_user,
                          label: "Verify with OTP or WhatsApp",
                          isVertical: true,
                        ),
                        SizedBox(height: 16),
                        _StepItem(
                          icon: Icons.chat_bubble_outline,
                          label: "Provide Basic Details",
                          isVertical: true,
                        ),
                        SizedBox(height: 16),
                        _StepItem(
                          icon: Icons.account_balance,
                          label: "Provide Loan Details",
                          isVertical: true,
                        ),
                        SizedBox(height: 16),
                        _StepItem(
                          icon: Icons.verified,
                          label: "Book appointment for branch visit",
                          isVertical: true,
                        ),
                      ],
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: _StepItem(
                            icon: Icons.qr_code,
                            label: "Scan QR\nto Login",
                          ),
                        ),
                        Flexible(
                          child: _StepItem(
                            icon: Icons.verified_user,
                            label: "Verify with OTP\nor WhatsApp",
                          ),
                        ),
                        Flexible(
                          child: _StepItem(
                            icon: Icons.chat_bubble_outline,
                            label: "Provide\nBasic Details",
                          ),
                        ),
                        Flexible(
                          child: _StepItem(
                            icon: Icons.account_balance,
                            label: "Provide\nLoan Details",
                          ),
                        ),
                        Flexible(
                          child: _StepItem(
                            icon: Icons.verified,
                            label: "Book appointment\nfor branch visit",
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // TRACK LOAN CARD
        TrackLoanCard(),

        const SizedBox(height: 20),

        // IMPORTANT LINKS
        Text(
          "Important Links",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: _LinkItem(
                icon: Icons.call,
                text: "Grievance Redressal & Cust. Care",
                onTap: AppLinks.opensachetPortal,
              ),
            ),

            _verticalDivider(),

            Flexible(
              child: _LinkItem(
                icon: Icons.account_balance,
                text: "Sachet Portal",
                onTap: AppLinks.opensachetPortal,
              ),
            ),

            _verticalDivider(),

            Flexible(
              child: _LinkItem(
                icon: Icons.info_outline,
                text: "About Gold Loan",
                onTap: AppLinks.opensachetPortal,
              ),
            ),

            _verticalDivider(),

            Flexible(
              child: _LinkItem(
                icon: Icons.report_problem,
                text: "Complaint Management System",
                onTap: AppLinks.opensachetPortal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// STEP ITEM
class _StepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isVertical;

  const _StepItem({
    required this.icon,
    required this.label,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      // MOBILE / SIDEBAR DESIGN (LIKE YOUR IMAGE)
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF4A67D6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 13, height: 1.3),
            ),
          ),
        ],
      );
    }

    // DESKTOP DESIGN (UNCHANGED)
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF4A67D6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// LINK ITEM
class _LinkItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _LinkItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Color(0xFF1C3FCA)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(color: Color(0xFF1C3FCA), fontSize: 12),
            softWrap: true, // allows wrapping
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
