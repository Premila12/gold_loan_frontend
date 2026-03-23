// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../data/datasources/auth_remote_datasource.dart';
// import '../../data/models/response.dart';
// import '../../data/repositories/repository_impl.dart';
// import '../repository/auth_repository.dart';
// import '../../../core/network/dio_client.dart';

// class FetchSessionUseCase {
//   final AuthRepository repository;

//   FetchSessionUseCase(this.repository);

//   Future<SessionResponse> call(String token, String qrId) async {
//     return await repository.fetchSession(token, qrId);
//   }
// }

// /// ✅ Riverpod Provider
// final fetchSessionUseCaseProvider = Provider<FetchSessionUseCase>((ref) {
//   final dio = DioClient.dio;

//   final remoteDataSource = AuthRemoteDatasource(dio);

//   final repository = AuthRepositoryImpl(remoteDataSource);

//   return FetchSessionUseCase(repository);
// });
