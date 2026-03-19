import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import 'left_desktopview.dart';
import 'left_mobileview.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return SizedBox(
      height: isDesktop ? double.infinity : null,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: const Color(0xFFDDF2F8))),

          (isDesktop || isTablet)
              ? const Positioned.fill(child: LeftDesktopView())
              : const LeftMobileView(),
        ],
      ),
    );
  }
}
