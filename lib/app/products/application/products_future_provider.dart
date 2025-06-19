import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/app/products/domain/repositories/i_product_repository.dart';
import 'package:payme/app/products/infrastructure/repositories/product_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final productRepositoryProvider = Provider<IProductRepository>(
  (ref) => ProductRepository(getIt<Dio>()),
);

final productsProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final _repository = ref.watch(productRepositoryProvider);
  final result = await _repository.getProducts();
  return result;
});


