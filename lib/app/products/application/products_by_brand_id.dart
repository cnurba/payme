import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/products/application/products_future_provider.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/core/failure/app_result.dart';

final productListByBrandIdFutureProvider = FutureProvider.autoDispose
    .family<List<Product>, String?>((ref, brandId) async {
      final productRepository = ref.watch(productRepositoryProvider);

      ApiResult result;
      if (brandId == null || brandId.isEmpty) {
        result = await productRepository.getProducts();
      } else {
        result = await productRepository.getProductsByBrandId(brandId);
      }

      if (result is ApiResultWithData<List<Product>>) {
        return result.data;
      } else {
        throw Exception('Failed to load products for brand ID: $brandId');
      }
    });
