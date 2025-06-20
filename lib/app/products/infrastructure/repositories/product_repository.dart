import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/products/domain/models/product.dart';
import 'package:payme/app/products/domain/repositories/i_product_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class ProductRepository implements IProductRepository {
  final Dio _dio;

  const ProductRepository(this._dio);

  @override
  Future<ApiResult> getProducts() async {
    return await handleFailure<ApiResult>(() async {
      log("START PRODUCT REQUEST");
      final responseData = await _dio.get(Endpoints.product.products);

      final products =
          (responseData.data as List)
              .map((clients) => Product.fromJson(clients))
              .toList();
      log("FINISH PRODUCT length  ${products.length}");
      return ApiResultWithData(data: products);
    });
  }

  @override
  Future<ApiResult> getProductsByBrandId(String brandId) async {
    return await handleFailure<ApiResult>(() async {
      log("START PRODUCT REQUEST");
      final responseData = await _dio.get(
        Endpoints.product.products,
        queryParameters: {"brandUuid": brandId},
      );

      final products =
          (responseData.data as List)
              .map((clients) => Product.fromJson(clients))
              .toList();
      log("FINISH PRODUCT length  ${products.length}");
      return ApiResultWithData<List<Product>>(data: products);
    });
  }

  @override
  Future<ApiResult> addProduct(
    String name,
    String description,
    String unitName,
    String brandId,
  ) async {
    return await handleFailure<ApiResult>(() async {
      log("START NEW PRODUCT REQUEST");
      final responseData = await _dio.post(
        Endpoints.product.products,
        data: {
          'name': name,
          'description': description,
          'unitName': unitName,
          'brandUuid': brandId,
          'articul': '',
        },
      );

      final Product product = Product.fromJson(responseData.data);

      log("FINISH NEW PRODUCT length");
      return ApiResultWithData<Product>(data: product);
    });
  }
}
