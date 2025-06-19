import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:payme/auth/domain/models/token.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
/// Authorization service.
class Authenticator {
  /// Secure storage instance.
  final ISecureStorage _secureStorage;
  final Dio _dio;

  Authenticator(this._secureStorage, this._dio);

  /// Get signed in token.
  ///
  /// Return null if will be thrown [PlatformException] and [FormatException].
  Future<Token?> getSignedToken() async {
    try {
      final token = await _secureStorage.read();
      log("Token: $token");
      return token;
    } on PlatformException {
      return null;
    } on FormatException {
      return null;
    } on DioException {
      return null;
    }
  }

  /// Check if user already signed in.
  Future<bool> isSignedIn() => getSignedToken().then((token) {
      return token != null;
    });

  Future<(ApiResult, bool)> clearSecureStorage() async {
    try {
      await _secureStorage.clear();
      return (ApiResultInitial(), true);
    } on PlatformException {
      return (ApiResultFailureClient(message: "platform_exception"), true);
    }
  }

  /// Refresh access token by refresh token.
  Future<(ApiResult, Token)> refresh(
    String refreshToken,
  ) async {
    try {
      final token = await _getTokenOrNull(refreshToken);
      if (token != null) {
        await _secureStorage.save(token);
        return (ApiResultInitial(), token);
      } else {
        return (ApiResultFailureClient(message: "empty_token"), Token.empty());
      }
    } on FormatException {
      return (
      ApiResultFailureClient(message: "format_exception"),
      Token.empty()
      );
    } on DioException {
      return (ApiResultFailureClient(message: "dio_exception"), Token.empty());
    } on PlatformException {
      return (
      ApiResultFailureClient(message: "platform_exception"),
      Token.empty()
      );
    }
  }

  Future<Token?> _getTokenOrNull(String refreshToken) async {
    final responseData = await _dio.post(Endpoints.auth.login, data: {
        "refresh_token": refreshToken,
      });
    if (responseData.statusCode == 200) {
      log("Response REFRESH ${responseData.data.toString()}");
      Map<String, dynamic> jsonData =
        responseData.data as Map<String, dynamic>;
      return Token(access: jsonData['access_token'], refresh: refreshToken);
    } else if (responseData.statusCode == 401) {
      // If the refresh token is invalid, return null
      return null;
    } else {
      // Handle other status codes as needed
      throw Exception("Failed to refresh token");
    }

  }
}
