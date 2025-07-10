import 'package:dio/dio.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';

/// Dio interceptor for intercepting request.
class DioInterceptor extends Interceptor  {
  /// Service for authentication.
  final IAuthRepository _authenticator;

  /// Dio client.
  final Dio _dio;

  DioInterceptor(this._dio, this._authenticator);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    options.headers.addAll(headers);

    if (!options.path.contains('GetToken')) {
      final token = await _authenticator.getSignedToken();
      if (token != null && token.access.isNotEmpty) {
        options.headers.addAll({"Authorization": 'Bearer ${token.access}'});
       } else {
        // If no token is available, you might want to handle it accordingly
        // For example, you could throw an error or log a warning
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   return super.onError(err, handler);
  // }


  //
  // @override
  // Future<void> onRequest(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) async {
  //   if (options.path.contains(
  //       'GetToken')) {
  //     handler.next(options);
  //     return;
  //   }
  //   //
  //   if (options.path.contains('resend')) {
  //     handler.next(options);
  //     return;
  //   }
  //
  //   final token = await _authenticator.getSignedToken();
  //   if(token == null || token.access.isEmpty) {
  //     handler.next(options);
  //     return;
  //   }
  //   final modifiedOptions = options
  //     ..headers.addAll(
  //       token == null ? {} : {'Authorization': 'Bearer ${token.access}'},
  //     );
  //
  //   handler.next(modifiedOptions);
  // }
  //
  // @override
  // Future<void> onError(
  //     DioException err, ErrorInterceptorHandler handler) async {
  //   final errorResponse = err.response;
  //   final invalidToken =
  //       errorResponse != null && errorResponse.data != null;
  //   if (errorResponse != null &&
  //       invalidToken &&
  //       errorResponse.statusCode == 401) {
  //     final token = await _authenticator.getSignedToken();
  //     handler.reject(err);
  //
  //     // token != null
  //     //     ? await _authenticator.refresh(token.refresh)
  //     //     : await _authenticator.();
  //
  //     // final refreshedToken = await _authenticator.getSignedToken();
  //     // if (refreshedToken != null) {
  //     //   handler.resolve(
  //     //     await _dio.fetch(
  //     //       errorResponse.requestOptions
  //     //         ..headers['Authorization'] = 'bearer $refreshedToken',
  //     //     ),
  //     //   );
  //     // }
  //     if (errorResponse.statusCode == 500) {
  //       handler.next(err);
  //     }
  //   } else {
  //     handler.reject(err);
  //   }
  //
  //   //handler.reject(err); //  next(err);
  // }
}
