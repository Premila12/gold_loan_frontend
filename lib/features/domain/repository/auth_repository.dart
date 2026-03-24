import '../../data/models/response.dart';

abstract class AuthRepository {
  //initauth
  Future<AuthInitResponse> initAuth();
  //qr
  Future<GenerateQrResponse> generateQr(String journeyId);
  //session
  Future<SessionFetchResponse> fetchSession(String authId, String journeyId);
  // user identify
  Future<UserIdentifyResponse> identifyUser(String phoneNumber, String pan, String dob);
  // otp init
  Future<OtpInitResponse> initOtp(String journeyId, String identifyToken);
  // otp validate
  Future<OtpValidateResponse> validateOtp(String sessionToken, String journeyId, String otp);
}






// abstract class AuthRepository {
//   Future<AuthInitResponse> authInit();
//   Future<QrResponse> generateQr(String token);
//   Future<SessionResponse> fetchSession(String token, String qrId);
// }
