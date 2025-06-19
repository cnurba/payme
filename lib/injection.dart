import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/domain/repositories/i_user_model_cache.dart';
import 'package:payme/auth/infrastucture/repositories/auth_repository.dart';
import 'package:payme/auth/infrastucture/repositories/user_model_cache.dart';

import 'auth/domain/repositories/i_secure_storage.dart';
import 'auth/infrastucture/repositories/secure_storage.dart';
import 'core/http/dio_interceptor.dart';

// Создай глобальный экземпляр GetIt
final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
          () => const FlutterSecureStorage());
  getIt.registerLazySingleton<ISecureStorage>(() => SecureStorage(getIt()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioInterceptor>(
          () => DioInterceptor(getIt(), getIt()));
  getIt.registerLazySingleton<IUserModelCache>(
      () => UserModelCache());  // Assuming UserModelCache is a class that manages user data caching;
  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepository(getIt<ISecureStorage>(), getIt<Dio>()));

  getIt.registerLazySingleton<IBrandRepository>(() => BrandRepository(getIt()));

}
