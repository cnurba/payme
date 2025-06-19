import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/auth/domain/models/token.dart';
import 'package:payme/auth/domain/models/user_model.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class AuthRepository implements IAuthRepository {
  final ISecureStorage _secureStorage;
  final Dio _dio;

  AuthRepository(this._secureStorage, this._dio);

  @override
  Future<ApiResult> login(String login, String password) async {
    return await handleFailure<ApiResult>(() async {
      log("LOGIN START}");
      final basicAuth =
          'Basic ${base64Encode(utf8.encode('$login:$password'))}';
      log("Basic Auth: $basicAuth");

      Map<String, String> headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': basicAuth
      };
      final responseData = await _dio.get(
        Endpoints.auth.login,
        options: Options(headers:headers),
      );
      log("FINISH LOGIN ${responseData.data.toString()}");
      await _secureStorage.save(Token.fromMap(responseData.data));
      return ApiResultWithData(data: Token.fromMap(responseData.data));
    });
  }

  @override
  Future<void> logout() async {
    await _secureStorage.clear();
  }

  @override
  Future<bool> isSignIn() async {
    final token = await _secureStorage.read();
    if (token == null) {
      return false;
    }
    return true;
  }

  @override
  Future<ApiResult> getCurrentUser() async{
    return await handleFailure<ApiResult>(() async {
      log("GET CURRENT USER START}");
      final responseData = await _dio.get(Endpoints.auth.currentUser);
      log("FINISH CURRENT USER ${responseData.data.toString()}");
      final user = UserModel.fromJson(responseData.data);
      return ApiResultWithData<UserModel>(data: user);
    });
  }

  @override
  Future<Token?> getSignedToken() async{
    return _secureStorage.read().then((token) {
      if (token != null) {
        return token;
      } else {
        return null;
      }
    }).catchError((error) {
      log("Error reading token: $error");
      return null;
    });
  }
}
