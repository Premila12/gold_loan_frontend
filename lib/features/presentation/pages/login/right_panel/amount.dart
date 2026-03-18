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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isValid = false;

  void _validateAmount(String value) {
    final amount = double.tryParse(value);
    final isValid = amount != null && amount > 0;

    if (_isValid != isValid) {
      setState(() => _isValid = isValid);
      widget.onValidationChanged?.call(_isValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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

        
        AmountField(
          amountFieldInfo: AmountFieldInfo( 
            height:50,
            width:489,
        
            controller: _controller,
            focusNode: _focusNode,
        
            hintText: "Loan Amount",
            currencyText: "INR",
        
          
           
            textColor: Colors.black,
            currencyTextColor: Colors.grey,
        
            borderColor: Colors.grey,
            // focusedBorderColor: Colors.grey,
        
            borderRadius: 12,
            
            borderWidth: 1,
        
            /// 🔹 Validation
            onChanged: _validateAmount,
        
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Amount required";
              }
        
              final amount = double.tryParse(value);
        
              if (amount == null) {
                return "Invalid number";
              }
        
              if (amount <= 0) {
                return "Amount must be greater than 0";
              }
        
              return null;
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}