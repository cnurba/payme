import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/products/application/products_by_brand_id.dart';
import 'package:payme/app/products/application/products_future_provider.dart';
import 'package:payme/app/products/presentation/new_product/widgets/product_text_field.dart';
import 'package:payme/core/failure/app_result.dart';

import '../domain/models/product.dart';

class NewProductParams {
  final String name;
  final String description;
  final String brandUuid;
  final String unitName;

  const NewProductParams({
    required this.name,
    required this.description,
    required this.brandUuid,
    required this.unitName,
  });
}

final newProductProvider = FutureProvider.autoDispose
    .family<Product?, NewProductParams>((ref, params) async {
      final repo = ref.watch(productRepositoryProvider);

      ApiResult result = await repo.addProduct(
        params.name,
        params.description,
        params.unitName,
        params.brandUuid,
      );

      if (result is ApiResultWithData) {
        ref.refresh(productListByBrandIdFutureProvider(params.brandUuid));
        return result.data as Product;
      } else {
        return null;
      }
    });
