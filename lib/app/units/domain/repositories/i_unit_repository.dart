import 'package:payme/core/failure/app_result.dart';

abstract class IUnitRepository {
  /// Fetches a list of units.
  Future<ApiResult> fetchUnits();

}