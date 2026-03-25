import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/response.dart';
import '../../domain/usecases/autth_init_usecase.dart';

class AuthController extends StateNotifier<AsyncValue<AuthInitResponse?>> {
  final AuthInitUseCase authInitUseCase;

  AuthController(this.authInitUseCase) : super(const AsyncData(null));

  Future<void> initAuth() async {
    print(" initAuth started");

    try {
      state = const AsyncLoading();

      final response = await authInitUseCase.call();

      print("Journey ID: ${response.journeyId}");

      // You will need it later for OTP, QR, etc.

      state = AsyncData(response);
    } catch (e) {
      print("ERROR: $e");
      state = AsyncError(e, StackTrace.current);
    }
  }
}
