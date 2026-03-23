import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class SessionFetchUseCase {
  final AuthRepository repository;

  SessionFetchUseCase(this.repository);

  Future<SessionFetchResponse> call(
    String authId,
    String journeyId,
  ) {
    return repository.fetchSession(authId, journeyId);
  }
}
























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
