import '../../data/models/response.dart';

abstract class AuthRepository {
  Future<AuthInitResponse> initAuth();
}





// abstract class AuthRepository {
//   Future<AuthInitResponse> authInit();
//   Future<QrResponse> generateQr(String token);
//   Future<SessionResponse> fetchSession(String token, String qrId);
// }
