import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLinks {
  static const String hdfcTrackApplication =
      'https://applynow.hdfc.bank.in/gold-loan/track-application-login-page';

  static const String privacyPolicy =
      'https://www.hdfc.bank.in/privacy-policy';

  static const String termsAndConditions =
      'https://www.hdfc.bank.in/terms-and-conditions';

  static const String noticeConsent =
      'https://www.hdfc.bank.in/smartwealth/consent';

  static const String compileManagement =
      'https://cms.rbi.org.in/cms/indexpage.html#eng';

  static const String sachetPortal =
      'https://sachet.rbi.org.in/';

  static const String grievanceRedressal =
      'https://www.hdfc.bank.in/need-help/grievance-redressal-digital';
      
  static const String goldLoan =
      'https://www.hdfc.bank.in/gold-loan';


  /// ================== COMMON LAUNCH FUNCTION ==================
  static Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  /// ================== PUBLIC METHODS ==================
  static Future<void> openTrackApplication() async {
    await _launchUrl(hdfcTrackApplication);
  }

  static Future<void> openPrivacyPolicy() async {
    await _launchUrl(privacyPolicy);
  }

  static Future<void> openTermsAndConditions() async {
    await _launchUrl(termsAndConditions);
  }

  static Future<void> openNoticeConsent() async {
    await _launchUrl(noticeConsent);
  }
  static Future<void> opencompileManagement() async {
    await _launchUrl(noticeConsent);
  }
  
  static Future<void> opensachetPortal() async {
    await _launchUrl(noticeConsent);
  }
  static Future<void> opengrievanceRedressal() async {
    await _launchUrl(noticeConsent);
  }
  static Future<void> opengoldLoan() async {
    await _launchUrl(noticeConsent);
  }

}