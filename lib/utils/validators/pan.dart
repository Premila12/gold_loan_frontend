import 'package:design_kit/design_kit/src/text_field/text_field_widget.dart';
import 'package:design_kit/design_kit/src/text_field/text_field_widget_info.dart';
import 'package:flutter/material.dart';

class PANField extends StatefulWidget {
  final Function(bool isValid) onValidationChanged;

  const PANField({
    super.key,
    required this.onValidationChanged,
  });

  @override
  State<PANField> createState() => _PANFieldState();
}

class _PANFieldState extends State<PANField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? _errorText;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);

    /// 🔥 Listen manually (since design kit has no onChanged)
    _controller.addListener(_onTextChanged);
  }

  /// 🔹 Handle typing
  void _onTextChanged() {
    String value = _controller.text.toUpperCase();

    /// 🔥 Force uppercase
    if (_controller.text != value) {
      _controller.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }

    /// 🔍 Validate
    _validatePAN(value);
  }

  /// 🔹 PAN validation (your logic)
  void _validatePAN(String value) {
    if (value.isEmpty) {
      _updateStatus(null, false);
      return;
    }

    if (value.length <= 3) {
      _updateStatus(null, false);
      return;
    }

    /// 4th char must be P
    if (value.length >= 4 && value[3] != 'P') {
      _updateStatus("Fourth character must be 'P' for personal PAN.", false);
      return;
    }

    /// Full validation
    if (value.length == 10) {
      final RegExp panRegex =
          RegExp(r'^[A-Z]{3}P[A-Z][0-9]{4}[A-Z]$');

      if (!panRegex.hasMatch(value)) {
        _updateStatus(
          "Invalid PAN number. Please enter a valid PAN number.",
          false,
        );
        return;
      }

      /// ✅ Valid
      _updateStatus(null, true);
    } else {
      _updateStatus(null, false);
    }
  }

  /// 🔹 Focus validation
  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final value = _controller.text.toUpperCase();

      if (value.isEmpty) return;

      if (value.length != 10) {
        _updateStatus("Please enter complete PAN number.", false);
        return;
      }

      final RegExp panRegex =
          RegExp(r'^[A-Z]{3}P[A-Z][0-9]{4}[A-Z]$');

      if (!panRegex.hasMatch(value)) {
        _updateStatus(
          "Invalid PAN number. Please enter a valid PAN number.",
          false,
        );
      }
    }
  }

  /// 🔹 Update UI + parent
  void _updateStatus(String? error, bool isValid) {
    if (_errorText != error) {
      setState(() => _errorText = error);
    }

    widget.onValidationChanged(isValid);
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
        /// 🔹 Design Kit TextField
        TextFieldWidget(
          textFieldWidgetInfo: TextFieldWidgetInfo(
            controller: _controller,
            hintText: "ABCDE1234F",
            textCapitalization: TextCapitalization.characters,
          ),
        ),

        /// 🔴 Error Text
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