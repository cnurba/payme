import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/core/http/endpoints.dart';

class OrderRepository implements IOrderRepository {
  OrderRepository(this._dio);

  final Dio _dio;

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

  @override
  Future<List<OrderDoc>> getMyOrderDocs() async {
    try {
      log("START ORDER DOCS REQUEST");
      final responseData = await _dio.get(Endpoints.order.orders);

      final List<OrderDoc> orderDocs = (responseData.data as List)
          .map((doc) => OrderDoc.fromJson(doc))
          .toList();
      log("FINISH ORDER DOCS ${responseData.data}");
      return orderDocs;
    } catch (e) {
      log("Error fetching objects: $e");
      return [];
    }
  }

  @override
  Future<List<OrderDocHistory>> getOrderDocHistory(String uuid) async{
    try {
      log("START ORDER DOCS History REQUEST");
      final responseData = await _dio.get(Endpoints.order.orders, queryParameters: {
        'uuid': uuid,
      });
     final List<OrderDocHistory> orderDocs = (responseData.data as List)
          .map((doc) => OrderDocHistory.fromJson(doc))
          .toList();
      log("FINISH ORDER DOCS History ${responseData.data}");
      return orderDocs;
    } catch (e) {
      log("Error fetching objects: $e");
      return [];
    }
  }
}
