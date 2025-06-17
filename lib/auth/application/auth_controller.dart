import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/auth/application/auth_state.dart';

import 'package:payme/auth/domain/repositories/i_auth_repository.dart';

class AuthController extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;

  AuthController(this._authRepository) : super(const AuthState());

  Future<void> login(String email, String password) async {
    final isLoggedIn = await _authRepository.login(email, password);
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = state.copyWith(isLoggedIn: false);
  }
}
