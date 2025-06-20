import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/floors/domain/models/floor_model.dart';
import 'package:payme/app/floors/domain/repositories/i_floor_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class FloorRepository implements IFloorRepository {
  FloorRepository(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult> fetchFloors() async {
    return await handleFailure<ApiResult>(() async {
      log("START FLOOR REQUEST");
      final responseData = await _dio.get(Endpoints.floor.floors);

      final floors =
          (responseData.data as List)
              .map((floors) => FloorModel.fromJson(floors))
              .toList();
      log("FINISH FLOOR length  ${floors.length}");
      return ApiResultWithData<List<FloorModel>>(data: floors);
    });
  }
}
