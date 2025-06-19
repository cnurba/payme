import 'package:payme/core/failure/app_result.dart';

abstract class IProductRepository {
  Future<ApiResult> getProducts();
  Future<ApiResult> getProductsByBrandId(String brandId);
}
