import 'package:payme/core/failure/app_result.dart';

abstract class IClientRepository {
  /// Fetches a list of units.
  Future<ApiResult> fetchClients();

}