import 'package:payme/core/failure/app_result.dart';

abstract class IProductRepository {
  Future<ApiResult> getProducts();
  Future<ApiResult> getProductsByBrandId(String brandId);
  Future<ApiResult> getProductsBySearchText(String searchText);
  Future<ApiResult> addProduct(String name, String description, String unitName, String brandId);
}
