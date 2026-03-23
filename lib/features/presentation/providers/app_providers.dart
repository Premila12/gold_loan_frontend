import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/network/dio_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/response.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/autth_init_usecase.dart';
import 'auth_controller.dart';


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
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  );
});

/// 4. UseCase
final authInitUseCaseProvider = Provider<AuthInitUseCase>((ref) {
  return AuthInitUseCase(
    ref.read(authRepositoryProvider),
  );
});

/// 5. Controller (IMPORTANT)
final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthInitResponse?>>(
  (ref) => AuthController(
    ref.read(authInitUseCaseProvider),
  ),
);