import '../repository/auth_repository.dart';
import '../../data/models/response.dart';

class OtpValidateUseCase {
  final AuthRepository repository;

  OtpValidateUseCase(this.repository);

  Future<OtpValidateResponse> call(String sessionToken, String journeyId, String otp) {
    return repository.validateOtp(sessionToken, journeyId, otp);
  }
}
