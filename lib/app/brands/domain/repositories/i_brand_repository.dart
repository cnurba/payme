import 'package:payme/core/failure/app_result.dart';

abstract class IBrandRepository {
  Future<ApiResult> getAllBrands();
}
