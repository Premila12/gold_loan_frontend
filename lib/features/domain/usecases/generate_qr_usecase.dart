// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../data/datasources/auth_remote_datasource.dart';
// import '../../data/models/response.dart';
// import '../../data/repositories/repository_impl.dart';
// import '../repository/auth_repository.dart';
// import '../../../core/network/dio_client.dart';

// class GenerateQrUseCase {
//   final AuthRepository repository;

//   GenerateQrUseCase(this.repository);

//   Future<QrResponse> call(String token) async {
//     return await repository.generateQr(token);
//   }
// }

// /// ✅ Riverpod Provider
// final generateQrUseCaseProvider = Provider<GenerateQrUseCase>((ref) {
//   final dio = DioClient.dio;

//   final remoteDataSource = AuthRemoteDatasource(dio);

//   final repository = AuthRepositoryImpl(remoteDataSource);

//   return GenerateQrUseCase(repository);
// });
