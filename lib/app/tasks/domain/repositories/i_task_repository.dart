import 'package:payme/core/failure/app_result.dart';

abstract class ITaskRepository {
  Future<ApiResult> getMyTasks();

  Future<ApiResult> done(String uuid,String result);
  Future<ApiResult> reject(String uuid,String result);
}
