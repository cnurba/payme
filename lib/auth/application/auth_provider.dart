import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/auth/application/auth_controller.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/domain/repositories/i_user_model_cache.dart';
import 'package:payme/injection.dart';

/// Provides the AuthController instance
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final authRepository = getIt<IAuthRepository>();
    return AuthController(authRepository, getIt<IUserModelCache>());
  },
);
