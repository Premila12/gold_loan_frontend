import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class AuthInitUseCase {
  final AuthRepository repository;

  AuthInitUseCase(this.repository);

  Future<AuthInitResponse> call() {
    return repository.initAuth();
  }
}




// class AuthInitUseCase {
//   final AuthRepository repository;

//   AuthInitUseCase(this.repository);

//   Future<AuthInitResponse> call() async {
//     return await repository.authInit();
//   }
// }

// /// Riverpod Provider
// final authInitUseCaseProvider = Provider<AuthInitUseCase>((ref) {
//   final dio = DioClient.dio;

//   final remoteDataSource = AuthRemoteDatasource(dio);

//   final repository = AuthRepositoryImpl(remoteDataSource);

//   return AuthInitUseCase(repository);
// });
