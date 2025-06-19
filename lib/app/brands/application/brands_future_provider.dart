import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final brandsRepositoryProvider = Provider<IBrandRepository>(
  (ref) => BrandRepository(getIt<Dio>()),
);

final brandsFutureProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final brandRepository = ref.watch(brandsRepositoryProvider);
  final result = await brandRepository.getAllBrands();
  return result;
});
