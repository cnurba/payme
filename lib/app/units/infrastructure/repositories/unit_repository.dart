import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payme/app/units/domain/models/unit_model.dart';
import 'package:payme/app/units/domain/repositories/i_unit_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class UnitRepository implements IUnitRepository {
  UnitRepository(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult> fetchUnits() async {
    return await handleFailure<ApiResult>(() async {
      log("START UNIT REQUEST");
      final responseData = await _dio.get(Endpoints.unit.units);
      log("FINISH UNIT ${responseData.data.toString()}");
      final units =
          (responseData.data as List)
              .map((units) => UnitModel.fromJson(units))
              .toList();
      log("FINISH UNIT length  ${units.length}");
      return ApiResultWithData(data: units);
    });
  }
}
