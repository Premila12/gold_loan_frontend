import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/network/dio_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/response.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/autth_init_usecase.dart';
import '../../domain/usecases/fetch_session_usecase.dart';
import '../../domain/usecases/generate_qr_usecase.dart';
import '../../domain/usecases/identify_user_usecase.dart';
import '../../domain/usecases/otp_init_usecase.dart';
import '../../domain/usecases/otp_validate_usecase.dart';
import 'auth_controller.dart';
import 'qr_controller.dart';
import 'otp_controller.dart';

/// 1. Dio
final dioProvider = Provider<Dio>((ref) {
  return DioClient.dio;
});

/// 2. Remote DataSource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.read(dioProvider));
});

/// 3. Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

/// 4. Use Cases
final authInitUseCaseProvider = Provider<AuthInitUseCase>((ref) {
  return AuthInitUseCase(ref.read(authRepositoryProvider));
});

final generateQrUseCaseProvider = Provider<GenerateQrUseCase>((ref) {
  return GenerateQrUseCase(ref.read(authRepositoryProvider));
});

final sessionFetchUseCaseProvider = Provider<SessionFetchUseCase>((ref) {
  return SessionFetchUseCase(ref.read(authRepositoryProvider));
});

// OTP Use Cases
final identifyUserUseCaseProvider = Provider<IdentifyUserUseCase>((ref) {
  return IdentifyUserUseCase(ref.read(authRepositoryProvider));
});

final otpInitUseCaseProvider = Provider<OtpInitUseCase>((ref) {
  return OtpInitUseCase(ref.read(authRepositoryProvider));
});

final otpValidateUseCaseProvider = Provider<OtpValidateUseCase>((ref) {
  return OtpValidateUseCase(ref.read(authRepositoryProvider));
});

/// 5. Controllers
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthInitResponse?>>(
      (ref) => AuthController(ref.read(authInitUseCaseProvider)),
    );

final qrControllerProvider =
    StateNotifierProvider<QrController, AsyncValue<GenerateQrResponse?>>(
      (ref) => QrController(
        ref.read(generateQrUseCaseProvider),
        ref.read(sessionFetchUseCaseProvider),
      ),
    );

final otpControllerProvider =
    StateNotifierProvider<OtpController, OtpState>(
      (ref) => OtpController(
        identifyUserUseCase: ref.read(identifyUserUseCaseProvider),
        otpInitUseCase: ref.read(otpInitUseCaseProvider),
        otpValidateUseCase: ref.read(otpValidateUseCaseProvider),
      ),
    );
