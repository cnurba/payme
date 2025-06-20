import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/app/objects/domain/repositories/i_object_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class ObjectRepository implements IObjectRepository {
  ObjectRepository(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult> fetchObjects() async {
    return await handleFailure<ApiResult>(() async {
      log("START OBJECT REQUEST");
      final responseData = await _dio.get(Endpoints.object.objects);
      final objects =
          (responseData.data as List)
              .map((object) => ObjectModel.fromJson(object))
              .toList();
      log("FINISH OBJECT length  ${objects.length}");
      return ApiResultWithData(data: objects);
    });
  }
}
