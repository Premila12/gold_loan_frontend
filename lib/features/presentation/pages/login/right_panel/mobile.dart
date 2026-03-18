import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_kit/design_kit/src/phonefield/phonefield.dart';
import 'package:design_kit/design_kit/src/phonefield/phonefield_info.dart';

class PhoneSection extends StatefulWidget {
  final Function(bool isValid) onValidationChanged;

  const PhoneSection({super.key, required this.onValidationChanged});

  @override
  State<PhoneSection> createState() => _PhoneSectionState();
}

class _PhoneSectionState extends State<PhoneSection> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  /// 🔍 Focus Change Logic
  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final text = _controller.text;

      if (text.isNotEmpty && text.length < 10) {
        setState(() {
          _errorText = "Please enter a valid 10-digit mobile number";
        });

        widget.onValidationChanged(false);
      }
    }
  }

  /// 🔍 Validation Logic
  void _validate(String value) {
    String? newError;

    if (value.isEmpty) {
      newError = null;
    } else if (!RegExp(r'^[6-9]').hasMatch(value)) {
      newError = "Number must start with 6, 7, 8, or 9";
    } else if (value.length < 10) {
      newError = null;
    } else if (RegExp(r'^[6-9]0{9}$').hasMatch(value)) {
      newError = "Please enter a valid 10-digit mobile number";
    } else {
      newError = null;
    }

    if (_errorText != newError) {
      setState(() {
        _errorText = newError;
      });
    }

    bool isValid = (newError == null && value.length == 10);
    widget.onValidationChanged(isValid);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Enter Mobile Number",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 8),

        PhoneField(
          phoneFieldInfo: PhoneFieldInfo(
            height: 48,
            controller: _controller,
            focusNode: _focusNode,
            padding: EdgeInsets.all(12),

            hintText: "Mobile Number",
            countryCode: "+91",
            flagEmoji: "🇮🇳",

            maxLength: 10,
            keyboardType: TextInputType.number,

            // backgroundColor: Colors.white,
            borderRadius: 12,
            borderWidth: 1,

            borderColor: _errorText != null ? Colors.red : Colors.grey,
            focusedBorderColor: _errorText != null ? Colors.red : Colors.grey,

            textStyle: const TextStyle(color: Colors.black),
            hintStyle: const TextStyle(color: Colors.grey),

            dividerColor: Colors.grey,
            dividerWidth: 1,
            onChanged: _validate,
          ),
        ),
        const SizedBox(height: 8),
        Text("We will send an OTP on this number"),

        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
