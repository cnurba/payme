import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/app/orders_for_acceptance/domain/repositories/i_order_for_acceptance_repository.dart';
import 'package:payme/core/http/endpoints.dart';

class OrderForAcceptanceRepository implements IOrderForAcceptanceRepository {
  OrderForAcceptanceRepository(this._dio);

  final Dio _dio;

  @override
  Future<bool> createAcceptance(OrderForAcceptance order) async {
    try {
      log("START ORDER ACCEPTANCE REQUEST");
      final orderData = order.toJson();
      final responseData = await _dio.post(
        Endpoints.order.acceptance,
        data: orderData,
      );
      log("FINISH ORDER ACCEPTANCE ${responseData.data}");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }

  @override
  Future<List<OrderForAcceptance>> getAllForAcceptance() async {
    try {
      log("START ORDER ACCEPTANCE REQUEST");
      final responseData = await _dio.get(Endpoints.order.acceptance);

      final List<OrderForAcceptance> orderDocs =
          (responseData.data as List)
              .map((doc) => OrderForAcceptance.fromJson(doc))
              .toList();
      log("FINISH ORDER ACCEPTANCE ${responseData.data}");
      return orderDocs;
    } catch (e) {
      log("Error fetching objects: $e");
      return [];
    }
  }
}
