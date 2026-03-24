import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class OtpInitUseCase {
  final AuthRepository repository;

  OtpInitUseCase(this.repository);

  Future<OtpInitResponse> call(String journeyId, String identifyToken) {
    return repository.initOtp(journeyId, identifyToken);
  }
}
