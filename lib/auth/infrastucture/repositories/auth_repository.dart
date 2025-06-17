import 'package:payme/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<bool> login(String email, String password) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => email == '123456' && password == '123',
    );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
