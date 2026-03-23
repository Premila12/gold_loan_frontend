class ApiEndpoints {
  static const String authInit = "/api/v1/auth/init";
  static const String fetchSession = "/api/v1/auth/session/fetch";

  static const String otpInit = "/api/v1/auth/otp/init";
  static const String otpValidate = "/api/v1/auth/otp/validate";

  static const String qrGenerate = "/api/v1/auth/qr/generate";
}


// Auth:
// POST /api/v1/auth/init
// POST /api/v1/auth/session/fetch


// OTP:
// POST /api/v1/auth/otp/init
// POST /api/v1/auth/otp/validate


// QR:
// POST /api/v1/auth/qr/generate
// POST /api/v1/auth/qr/validate
// POST /api/v1/auth/qr/approve


// WhatsApp:
// POST /api/v1/auth/whatsapp/init
// POST /api/v1/auth/whatsapp/validate
// POST /api/v1/auth/whatsapp/approve
// POST /api/v1/auth/whatsapp/deny
// POST /api/v1/auth/whatsapp/status


// Customer/User:
// POST /api/v1/user/identify
// POST /api/v1/user/details/fetch
// GET  /api/v1/user/test