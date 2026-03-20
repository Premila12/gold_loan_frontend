import 'package:design_kit/design_kit/src/amountfield/amount_field.dart';
import 'package:design_kit/design_kit/src/amountfield/amount_field_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountSection extends StatefulWidget {
  final ValueChanged<bool>? onValidationChanged;

  const AmountSection({super.key, this.onValidationChanged});

  @override
  State<AmountSection> createState() => _AmountSectionState();
}

class _AmountSectionState extends State<AmountSection> {
  final _formKey = GlobalKey<FormState>(); // ✅ KEPT
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isValid = false;
  bool _hasInteracted = false;
  String? _errorText;

  // Limits
  static const double minAmount = 10000;
  static const double maxAmount = 35000000; // 3.5 Crores

  @override
  void initState() {
    super.initState();

    /// 🔹 Detect focus loss (blur)
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _hasInteracted = true;
        });

        _validateAmount(_controller.text);

        /// Optional: still trigger form validation lifecycle
        _formKey.currentState?.validate();
      }
    });
  }

  /// 🔹 Validation Logic (manual UI control)
  void _validateAmount(String value) {
    final cleanedValue = value.replaceAll(',', '');
    final amount = double.tryParse(cleanedValue);

    String? error;

    if (_hasInteracted) {
      if (value.isEmpty) {
        error = "Loan amount should be between ₹10,000 to ₹3.5 Crores";
      } else if (amount == null) {
        error = "Invalid loan amount";
      } else if (amount < minAmount) {
        error = "Minimum loan amount is ₹10,000";
      } else if (amount > maxAmount) {
        error = "Maximum loan amount is ₹3.5 Crores";
      }
    }

    final isValid = error == null;

    if (_errorText != error || _isValid != isValid) {
      setState(() {
        _errorText = error;
        _isValid = isValid;
      });

      widget.onValidationChanged?.call(_isValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form( // ✅ KEPT FORM
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 LABEL
          Text(
            "Enter Required Loan Amount (₹)",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          /// 🔹 AMOUNT FIELD
          AmountField(
            amountFieldInfo: AmountFieldInfo(
              height: 50,
              width: 489,
              controller: _controller,
              focusNode: _focusNode,
              hintText: "Loan Amount",
              currencyText: "INR",
              textColor: Colors.black,
              currencyTextColor: Colors.grey,
              borderColor: Colors.grey,
              borderRadius: 12,
              borderWidth: 1,

              /// 🔹 On Change
              onChanged: (value) {
                _validateAmount(value);

                /// After interaction → optional form trigger
                if (_hasInteracted) {
                  _formKey.currentState?.validate();
                }
              },

              /// ❌ Keep validator EMPTY to prevent internal error UI
              validator: (_) => null,
            ),
          ),

          /// 🔴 ERROR TEXT OUTSIDE BORDER
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}