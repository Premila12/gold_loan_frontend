import 'package:dio/dio.dart';
import '../../../core/constants/constants/api_endpoints.dart';
import '../models/response.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthInitResponse> initAuth() async {
    final response = await dio.post(
      ApiEndpoints.authInit,
      options: Options(
        headers: {
          "journeyName": "LOGIN",
        },
      ),
    );

    print("AUTH INIT RESPONSE: ${response.data}");//debug

    return AuthInitResponse.fromJson(response.data);
  }
}




















//   //qrgenerates
//   Future<QrResponse> generateQr(String token) async {
//     final response = await dio.post(
//       ApiEndpoints.qrGenerate,
//       options: Options(
//         headers: {
//           "Authorization": "Bearer $token",
//           "User-Agent": "system-user",
//         },
//       ),
//     );

//     return QrResponse.fromJson(response.data);
//   }

//   //session
//   Future<SessionResponse> fetchSession(String token, String qrId) async {
//     final response = await dio.get(
//       "/api/v1/auth/session/fetch/$qrId",
//       options: Options(headers: {"Authorization": "Bearer $token"}),
//     );

//     return SessionResponse.fromJson(response.data);
//   }
// }
