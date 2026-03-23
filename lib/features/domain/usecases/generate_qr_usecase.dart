import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class GenerateQrUseCase {
  final AuthRepository repository;

  GenerateQrUseCase(this.repository);

  Future<GenerateQrResponse> call(String journeyId) {
    return repository.generateQr(journeyId);
  }
}















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
