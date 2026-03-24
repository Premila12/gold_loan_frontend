import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../utils/validators/dob.dart';
import '../../../../../utils/validators/pan.dart';

class IdentifySection extends StatefulWidget {
  final Function(bool) onValidationChanged;
  final Function(String value)? onValueChanged;

  const IdentifySection({
    super.key,
    required this.onValidationChanged,
    this.onValueChanged,
  });

  @override
  State<IdentifySection> createState() => _IdentifySectionState();
}

class _IdentifySectionState extends State<IdentifySection> {
  String selected = 'dob';
  bool isDobValid = false;
  bool isPanValid = false;

  /// Notify parent
  void _notifyParent() {
    widget.onValidationChanged(
      selected == 'dob' ? isDobValid : isPanValid,
    );
  }

  /// Handle selection change
  void _onSelectionChanged(String value) {
    setState(() {
      selected = value;
      isDobValid = false;
      isPanValid = false;
    });

    _notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER + OPTIONS (RESPONSIVE)
        isMobile
            /// 📱 MOBILE VIEW
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildDobOption(),
                      const SizedBox(width: 16),
                      _buildPanOption(),
                    ],
                  ),
                ],
              )
              //tablet and Desktop 
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _title(),
                  const SizedBox(width: 16),
                  _buildDobOption(),
                  const SizedBox(width: 12),
                  _buildPanOption(),
                ],
              ),

        const SizedBox(height: 6),

        // FIELD (DOB / PAN)
        selected == 'dob'
            ? DOBField(
                onValidationChanged: (isValid) {
                  isDobValid = isValid;
                  _notifyParent();
                },
                onValueChanged: widget.onValueChanged,
              )
            : PANField(
                onValidationChanged: (isValid) {
                  isPanValid = isValid;
                  _notifyParent();
                },
                onValueChanged: widget.onValueChanged,
              ),
      ],
    );
  }

  /// 🔹 Title Widget
  Widget _title() {
    return Text(
      "Identify Using",
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  /// 🔹 DOB Option
  Widget _buildDobOption() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: 'dob',
          groupValue: selected,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) => _onSelectionChanged(value!),
        ),
        Text(
          "Date of Birth",
          style: GoogleFonts.inter(fontSize: 14),
        ),
      ],
    );
  }

  /// 🔹 PAN Option
  Widget _buildPanOption() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: 'pan',
          groupValue: selected,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) => _onSelectionChanged(value!),
        ),
        Text(
          "PAN",
          style: GoogleFonts.inter(fontSize: 14),
        ),
      ],
    );
  }
}