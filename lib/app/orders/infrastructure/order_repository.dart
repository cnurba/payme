import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/app/objects/domain/repositories/i_object_repository.dart';
import 'package:payme/app/orders/domain/models/order_model.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/http/endpoints.dart';
import 'package:payme/core/http/handle_failure.dart';

class OrderRepository implements IOrderRepository {
  OrderRepository(this._dio);

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

  @override
  Future<bool> addOrder(OrderModel order) async {
    try {
      log("START ORDER MODEL REQUEST");
      final orderData = order.toJson();
      final responseData = await _dio.post(
        Endpoints.order.orders,
        data: orderData,
      );
      log("FINISH ORDER MODEL ${responseData.data}");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }
}
