import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payme/app/clients/domain/models/client_model.dart';
import 'package:payme/app/clients/domain/repositories/i_client_repository.dart';
import 'package:payme/app/units/domain/models/unit_model.dart';
import 'package:payme/app/units/domain/repositories/i_unit_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class ClientRepository implements IClientRepository {
  ClientRepository(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult> fetchClients() async {
    return await handleFailure<ApiResult>(() async {
      log("START CLIENT REQUEST");
      final responseData = await _dio.get(Endpoints.client.clients);
      log("FINISH CLIENT ${responseData.data.toString()}");
      final clients =
          (responseData.data as List)
              .map((client) => ClientModel.fromJson(client))
              .toList();
      log("FINISH CLIENT length  ${clients.length}");
      return ApiResultWithData(data: clients);
    });
  }
}
