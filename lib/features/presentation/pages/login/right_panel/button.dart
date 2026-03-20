import 'package:design_kit/design_kit/src/primary_button/button_widget.dart';
import 'package:design_kit/design_kit/src/primary_button/button_widget_info.dart';
import 'package:flutter/material.dart';

class ButtonSection extends StatelessWidget {
  final bool isMobileValid;
  final bool isIdentifyValid;
  final bool isAmountValid;
  final bool isConsentChecked;

  const ButtonSection({
    super.key,
    required this.isMobileValid,
    required this.isIdentifyValid,
    required this.isAmountValid,
    required this.isConsentChecked,
  });

  bool get _isEnabled =>
      isMobileValid && isIdentifyValid && isAmountValid && isConsentChecked;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      buttonWidgetInfo: ButtonWidgetInfo(
        buttonText: "Login ",
        height: 50,
        width: 200,
        borderRadius: 12,

       
       
        

        backgroundColor: _isEnabled ? Colors.blue : Colors.grey.shade400,

        textColor: Colors.white,

        onPressed: _isEnabled
            ? () {
                print("Login Clicked ✅");
              }
            : null,
      ),
    );
  }
}
