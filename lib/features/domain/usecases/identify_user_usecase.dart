import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class IdentifyUserUseCase {
  final AuthRepository repository;

  IdentifyUserUseCase(this.repository);

  Future<UserIdentifyResponse> call(String phoneNumber, String pan, String dob) {
    return repository.identifyUser(phoneNumber, pan, dob);
  }
}
