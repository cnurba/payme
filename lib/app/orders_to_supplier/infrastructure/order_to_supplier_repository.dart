import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/app/orders_for_acceptance/domain/repositories/i_order_for_acceptance_repository.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';
import 'package:payme/app/orders_to_supplier/domain/repositories/i_order_to_supplier_repository.dart';
import 'package:payme/core/http/endpoints.dart';

class OrderToSupplierRepository implements IOrderToSupplierRepository {
  OrderToSupplierRepository(this._dio);

  final Dio _dio;

  @override
  Future<bool> createOrderToSupplier(Map<String, dynamic> json) async {
    try {
      log("START ORDER SUPPLIER REQUEST");
      final responseData = await _dio.post(
        Endpoints.order.supplier,
        data: json,
      );
      log("FINISH ORDER SUPPLIER ${responseData.data}");
      return true;
    } catch (e) {
      log("Error fetching objects: $e");
      return false;
    }
  }

  @override
  Future<List<OrderToSupplier>> getAllForSupplier() async {
    try {
      log("START ORDER SUPPLIER REQUEST");
      final responseData = await _dio.get(Endpoints.order.supplier);

      final List<OrderToSupplier> orderDocs =
          (responseData.data as List)
              .map((doc) => OrderToSupplier.fromJson(doc))
              .toList();
      log("FINISH ORDER SUPPLIER ${responseData.data}");
      return orderDocs;
    } catch (e) {
      log("Error fetching objects: $e");
      return [];
    }
  }
}
