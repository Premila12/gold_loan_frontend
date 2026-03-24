import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthInitResponse> initAuth() {
    return remoteDataSource.initAuth();
  }

  //Qr
  @override
  Future<GenerateQrResponse> generateQr(String journeyId) {
    return remoteDataSource.generateQr(journeyId: journeyId);
  }

  //session
  @override
  Future<SessionFetchResponse> fetchSession(String authId, String journeyId) {
    return remoteDataSource.fetchSession(authId: authId, journeyId: journeyId);
  }

  // user identify
  @override
  Future<UserIdentifyResponse> identifyUser(String phoneNumber, String pan, String dob) {
    return remoteDataSource.identifyUser(phoneNumber: phoneNumber, pan: pan, dob: dob);
  }

  // otp init
  @override
  Future<OtpInitResponse> initOtp(String journeyId, String identifyToken) {
    return remoteDataSource.initOtp(journeyId: journeyId, identifyToken: identifyToken);
  }

  // otp validate
  @override
  Future<OtpValidateResponse> validateOtp(String sessionToken, String journeyId, String otp) {
    return remoteDataSource.validateOtp(sessionToken: sessionToken, journeyId: journeyId, otp: otp);
  }
}


// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDatasource remoteDataSource;

//   AuthRepositoryImpl(this.remoteDataSource);

//   // ✅ AUTH INIT
//   @override
//   Future<AuthInitResponse> authInit() async {
//     return await remoteDataSource.initAuth();
//   }

//   // ✅ QR GENERATE
//   @override
//   Future<QrResponse> generateQr(String token) async {
//     return await remoteDataSource.generateQr(token);
//   }

//   // ✅ SESSION FETCH
//   @override
//   Future<SessionResponse> fetchSession(String token, String qrId) async {
//     return await remoteDataSource.fetchSession(token, qrId);
//   }
// }
