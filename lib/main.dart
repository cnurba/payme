import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/core/http/dio_interceptor.dart';
import 'package:payme/injection.dart';
import 'package:payme/run_payme_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  getIt<Dio>()
    ..options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 3000),
    )
    ..interceptors.add(getIt<DioInterceptor>());
  runApp(ProviderScope(child: const PayMeApp()));
}

_init() async {
  initDependencies();
}
