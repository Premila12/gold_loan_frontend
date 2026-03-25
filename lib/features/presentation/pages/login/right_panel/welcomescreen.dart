import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final horizontalPadding = isDesktop ? 60.0 : 20.0;
    final logoHeight = isDesktop ? 40.0 : 22.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08173A),
        toolbarHeight: isDesktop ? 72 : 48,
        automaticallyImplyLeading: false, // Remove back button
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              Image.asset(
                "assets/images/hdfc_logo.png",
                height: logoHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to HDFC Bank",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C3FCA),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
