import 'package:payme/core/failure/app_result.dart';

abstract class IObjectRepository {
  /// Fetches a list of units.
  Future<ApiResult> fetchObjects();
}
