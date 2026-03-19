import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F0FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Steps to Follow",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _StepItem(icon: Icons.qr_code, label: "Scan QR\nto Login"),
                  Text("or"),
                  _StepItem(
                    icon: Icons.verified_user,
                    label: "Verify with OTP\nor WhatsApp",
                  ),
                  _StepItem(
                    icon: Icons.chat_bubble_outline,
                    label: "Provide\nBasic Details",
                  ),
                  _StepItem(
                    icon: Icons.account_balance,
                    label: "Provide\nLoan Details",
                  ),
                  _StepItem(
                    icon: Icons.verified,
                    label: "Book appointment\nfor branch visit",
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// 🔹 TRACK LOAN CARD
        Container(
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
                onTap: () {
                  AppLinks.openTrackApplication();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
          ),
        ),

        const SizedBox(height: 20),

        /// 🔹 IMPORTANT LINKS
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

/// 🔹 STEP ITEM
class _StepItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StepItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       Container(
          padding: const EdgeInsets.all(10), // 👈 ADD PADDING HERE
          decoration: const BoxDecoration(
            color: Color(0xFF4A67D6), // blue background
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 11),
        ),
      ],
    );
  }
}

/// 🔹 LINK ITEM
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
            style:  GoogleFonts.inter(color: Color(0xFF1C3FCA), fontSize: 12),
            softWrap: true, // allows wrapping
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
