import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payme/app/brands/domain/models/brand.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class BrandRepository implements IBrandRepository {
  final Dio _dio;

  const BrandRepository(this._dio);

  @override
  Future<ApiResult> getAllBrands() async {
    return await handleFailure<ApiResult>(() async {
      log("START BRAND REQUEST");
      final responseData = await _dio.get(Endpoints.brand.brands);
      log("FINISH BRAND ${responseData.data.toString()}");
      final brands = (responseData.data as List)
          .map((clients) => Brand.fromJson(clients))
          .toList();
      log("FINISH BRANDS length  ${brands.length}");
      return ApiResultWithData(data: brands);
    });
  }
}
