import '../../data/models/response.dart';

abstract class AuthRepository {
  //initauth
  Future<AuthInitResponse> initAuth();
  //qr
  Future<GenerateQrResponse> generateQr(String journeyId);
  //session
  Future<SessionFetchResponse> fetchSession(String authId, String journeyId);
}





// abstract class AuthRepository {
//   Future<AuthInitResponse> authInit();
//   Future<QrResponse> generateQr(String token);
//   Future<SessionResponse> fetchSession(String token, String qrId);
// }
