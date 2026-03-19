import 'package:design_kit/design_kit/src/text_field/text_field_widget.dart';
import 'package:design_kit/design_kit/src/text_field/text_field_widget_info.dart';
import 'package:flutter/material.dart';

class DOBField extends StatefulWidget {
  final Function(bool isValid) onValidationChanged;

  const DOBField({
    super.key,
    required this.onValidationChanged,
  });

  @override
  State<DOBField> createState() => _DOBFieldState();
}

class _DOBFieldState extends State<DOBField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? _errorText;

  @override
  void initState() {
    super.initState();

    /// Listen for focus change
    _focusNode.addListener(_onFocusChange);

    /// Listen for typing
    _controller.addListener(_onTextChanged);
  }

  /// 🔹 Handle focus out validation
  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final text = _controller.text;

      if (text.isNotEmpty && text.length < 10) {
        _updateStatus(
          "Please enter a valid DOB (DD/MM/YYYY)",
          false,
        );
      } else {
        _validateDOB(text);
      }
    }
  }

  /// 🔹 Handle typing + formatting
  void _onTextChanged() {
    String value = _controller.text;

    /// Remove non-digits
    String digits = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 8) {
      digits = digits.substring(0, 8);
    }

    /// Format as DD/MM/YYYY
    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];

      if ((i == 1 || i == 3) && i != digits.length - 1) {
        formatted += '/';
      }
    }

    /// Prevent infinite loop
    if (formatted != value) {
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    /// Validate while typing
    _validateDOB(formatted);
  }

  /// 🔹 Main validation logic
  void _validateDOB(String value) {
    String errorMessage =
        "Invalid Date of Birth. Please enter a valid date of birth.";

    List<String> parts = value.split('/');

    bool isValid = false;

    /// Day validation
    if (parts.isNotEmpty && parts[0].length == 2) {
      int? day = int.tryParse(parts[0]);
      if (day == null || day < 1 || day > 31) {
        _updateStatus(errorMessage, false);
        return;
      }
    }

    /// Month validation
    if (parts.length > 1 && parts[1].length == 2) {
      int? month = int.tryParse(parts[1]);
      if (month == null || month < 1 || month > 12) {
        _updateStatus(errorMessage, false);
        return;
      }
    }

    /// Year validation + final check
    if (parts.length > 2 && parts[2].length == 4) {
      int? year = int.tryParse(parts[2]);
      if (year == null || year < 1951 || year > 2008) {
        _updateStatus(errorMessage, false);
        return;
      }

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      int maxDays = _daysInMonth(month, year);
      if (day > maxDays) {
        _updateStatus(errorMessage, false);
        return;
      }

      isValid = true;
    }

    _updateStatus(null, isValid);
  }

  /// 🔹 Days in month (with leap year)
  int _daysInMonth(int month, int year) {
    if (month == 2) {
      bool isLeap =
          (year % 4 == 0 && year % 100 != 0) ||
          (year % 400 == 0);
      return isLeap ? 29 : 28;
    }

    const monthDays = [
      31, 28, 31, 30, 31, 30,
      31, 31, 30, 31, 30, 31
    ];

    return monthDays[month - 1];
  }

  /// 🔹 Update UI + parent
  void _updateStatus(String? error, bool validStatus) {
    if (_errorText != error) {
      setState(() => _errorText = error);
    }

    widget.onValidationChanged(validStatus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_onTextChanged);

    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Design Kit Text Field
        TextFieldWidget(
          textFieldWidgetInfo: TextFieldWidgetInfo(
            controller: _controller,
            hintText: "DD/MM/YYYY",
            keyboardType: TextInputType.number,
            suffixIcon: Icons.calendar_today,
          ),
        ),

        /// 🔴 Error text
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Text(
              _errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}