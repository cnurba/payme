import 'package:payme/auth/domain/models/token.dart';
import 'package:payme/core/failure/app_result.dart';

abstract class IAuthRepository {
  Future<ApiResult> login(String email, String password);
  Future<void> logout();
  Future<bool> isSignIn();
  Future<ApiResult> getCurrentUser();
  Future<Token?> getSignedToken();
}
