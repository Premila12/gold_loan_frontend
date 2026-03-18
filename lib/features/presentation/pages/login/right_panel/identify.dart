import 'package:flutter/material.dart';
// import '../../../../../utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/validators/dob.dart';
import '../../../../../utils/validators/pan.dart';

class IdentifySection extends StatefulWidget {
  final Function(bool) onValidationChanged;

  const IdentifySection({
    super.key,
    required this.onValidationChanged,
  });

  @override
  State<IdentifySection> createState() => _IdentifySectionState();
}

class _IdentifySectionState extends State<IdentifySection> {
  String selected = 'dob';

  bool isDobValid = false;
  bool isPanValid = false;

  /// 🔹 Notify parent based on selection
  void _notifyParent() {
    if (selected == 'dob') {
      widget.onValidationChanged(isDobValid);
    } else {
      widget.onValidationChanged(isPanValid);
    }
  }

  /// 🔹 Handle toggle change
  void _onSelectionChanged(String value) {
    setState(() {
      selected = value;

      // reset validation when switching
      isDobValid = false;
      isPanValid = false;
    });

    _notifyParent();
  }

 @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            "Identify Using",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(width: 16),

          /// DOB Radio
          Row(
            children: [
              Radio<String>(
                value: 'dob',
                groupValue: selected,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) =>
                    _onSelectionChanged(value!),
              ),
              Text(
                "Date of Birth",
                style: GoogleFonts.inter(fontSize: 14),
              ),
            ],
          ),

          const SizedBox(width: 12),

          /// PAN Radio
          Row(
            children: [
              Radio<String>(
                value: 'pan',
                groupValue: selected,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) =>
                    _onSelectionChanged(value!),
              ),
               Text(
                "PAN",
                style: GoogleFonts.inter(fontSize: 14),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 6),


      if (selected == 'dob')
        DOBField(
          onValidationChanged: (isValid) {
            isDobValid = isValid;
            _notifyParent();
          },
        )
      else
        PANField(
          onValidationChanged: (isValid) {
            isPanValid = isValid;
            _notifyParent();
          },
        ),
    ],
  );
}
}