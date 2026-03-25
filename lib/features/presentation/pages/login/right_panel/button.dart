import 'package:design_kit/design_kit.dart';
import 'package:design_kit/design_kit/src/primary_button/button_widget.dart';
import 'package:design_kit/design_kit/src/primary_button/button_widget_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../features/presentation/providers/app_providers.dart';
import '../../../../../features/presentation/providers/otp_controller.dart';

class ButtonSection extends ConsumerWidget {
  final bool isMobileValid;
  final bool isIdentifyValid;
  final bool isAmountValid;
  final bool isConsentChecked;
  final String phoneNumber;
  final String identifyValue; // DOB (DD/MM/YYYY) or PAN

  const ButtonSection({
    super.key,
    required this.isMobileValid,
    required this.isIdentifyValid,
    required this.isAmountValid,
    required this.isConsentChecked,
    required this.phoneNumber,
    required this.identifyValue,
  });

  bool get _isEnabled =>
      isMobileValid && isIdentifyValid && isAmountValid && isConsentChecked;

  /// Converts DD/MM/YYYY → YYYY-MM-DD (API format) if it looks like a date,
  /// otherwise returns it as-is (for PAN).
  String _formatIdentifyValue(String value) {
    if (value.contains('/') && value.length == 10) {
      final parts = value.split('/');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1]}-${parts[0]}';
      }
    }
    return value;
  }

  /// Shows the masked phone hint (e.g. "XXXXXX7654")
  String _maskPhone(String phone) {
    if (phone.length >= 4) {
      return '${'X' * (phone.length - 4)}${phone.substring(phone.length - 4)}';
    }
    return phone;
  }

  void _onLoginPressed(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authControllerProvider);
    final journeyId = authState.value?.journeyId;

    if (journeyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Session not ready. Please wait.")),
      );
      return;
    }

    final formattedValue = _formatIdentifyValue(identifyValue);

    // Determine if it's DOB or PAN based on the value format
    final isDob = identifyValue.contains('/');

    // Call OTP flow
    ref
        .read(otpControllerProvider.notifier)
        .startOtpFlow(
          phoneNumber: phoneNumber,
          pan: isDob ? '' : formattedValue,
          dob: isDob ? formattedValue : '',
          journeyId: journeyId,
        );

    // Show OTP dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _OtpDialogListener(
          phoneHint: _maskPhone(phoneNumber),
          journeyId: journeyId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWidget(
      buttonWidgetInfo: ButtonWidgetInfo(
        buttonText: "Login > ",
        height: 50,
        width: 200,
        borderRadius: 12,
        backgroundColor: _isEnabled
            ? const Color(0xFF1C3FCA)
            : Colors.grey.shade400,
        textColor: Colors.white,
        onPressed: _isEnabled ? () => _onLoginPressed(context, ref) : null,
      ),
    );
  }
}

class _OtpDialogListener extends ConsumerWidget {
  final String phoneHint;
  final String journeyId;

  const _OtpDialogListener({required this.phoneHint, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpControllerProvider);

    // Auto-close dialog on success
    if (otpState.status == OtpStatus.validated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Login Successful!"),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    final isLoading =
        otpState.status == OtpStatus.loading ||
        otpState.status == OtpStatus.validating;

    return OtpDialogWidget(
      otpDialogWidgetInfo: OtpDialogWidgetInfo(
        phoneHint: phoneHint,
        secondsLeft: otpState.secondsLeft,
        isLoading: isLoading,
        errorMessage: otpState.errorMessage,
        onSubmit: (otp) {
          ref
              .read(otpControllerProvider.notifier)
              .submitOtp(otp: otp, journeyId: journeyId);
        },
        onResend: () {
          ref.read(otpControllerProvider.notifier).resendOtp(journeyId);
        },
        onClose: () {
          ref.read(otpControllerProvider.notifier).reset();
          Navigator.pop(context);
        },
      ),
    );
  }
}
