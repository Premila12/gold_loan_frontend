import 'package:flutter/material.dart';
import '../../../../utils/responsive.dart';
import './left_panel/left_panel.dart';
import './right_panel/right_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final horizontalPadding = isDesktop ? 60.0 : 20.0;
    final logoHeight = isDesktop ? 40.0 : 22.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08173A),
        toolbarHeight: isDesktop ? 72 : 48,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/hdfc_logo.png",
                height: logoHeight,
                fit: BoxFit.contain,
              ),
              Image.asset(
                "assets/images/secure.png",
                height: logoHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),

      body: (isDesktop ||isTablet)
          ? Row(
              children: const [
                Flexible(flex: 3, child: LeftPanel()),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                     child: RightPanel(),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: const [
                  LeftPanel(), 
                  RightPanel(),
                ],
              ),
            ),
    );
  }
}
