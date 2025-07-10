import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/tasks/domain/models/task.dart';
import 'package:payme/app/tasks/domain/repositories/i_task_repository.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class TaskRepository extends ITaskRepository {
  final Dio _dio;
  final ISecureStorage _storage;

  TaskRepository(this._dio, this._storage);

  @override
  Future<ApiResult> done(String uuid, String result) async {
    return await handleFailure<ApiResult>(() async {
      log("START TASK DONE REQUEST");

      final responseData = await _dio.post(
        Endpoints.task.myTasks,
        data: {"uuid": uuid, "result": result, "done": true},
      );

      log("FINISH TASK DONE ${responseData.data.toString()}");
      return ApiResultWithData(data: true);
    });
  }

  @override
  Future<ApiResult> getMyTasks() async {
    return await handleFailure<ApiResult>(() async {
      log("START TASK REQUEST");
      final responseData = await _dio.get(Endpoints.task.myTasks,queryParameters: {
        'Authorization': 'Bearer ${(await _storage.read())?.access}'
      });
      log("FINISH TASK ${responseData.data.toString()}");
      final tasks =
          (responseData.data as List)
              .map((clients) => Task.fromJson(clients))
              .toList();
      log("FINISH BRANDS length  ${tasks.length}");
      return ApiResultWithData(data: tasks);
    });
  }

  @override
  Future<ApiResult> reject(String uuid, String result) async {
    return await handleFailure<ApiResult>(() async {
      log("START TASK reject REQUEST");

      final responseData = await _dio.post(
        Endpoints.task.myTasks,
        data: {"uuid": uuid, "result": result, "done": false},
      );

      log("FINISH TASK reject ${responseData.data.toString()}");
      return ApiResultWithData(data: true);
    });
  }
}
