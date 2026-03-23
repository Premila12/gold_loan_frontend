import 'package:dio/dio.dart';
import '../constants/config/env.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
}
// class DioClient {
//   final Dio dio;

//   DioClient()
//       : dio = Dio(
//           BaseOptions(
//             baseUrl: Env.baseUrl, 
//             headers: {
//               'Content-Type': 'application/json',
//             },
//           ),
//         );

//   Future<Response> post(String path, {dynamic data}) async {
//     return await dio.post(path, data: data);
//   }
// }