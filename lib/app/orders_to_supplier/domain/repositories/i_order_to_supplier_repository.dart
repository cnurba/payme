import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';

abstract class IOrderToSupplierRepository {
  Future<List<OrderToSupplier>> getAllForSupplier();

  Future<bool> createOrderToSupplier(Map<String, dynamic> json);
}
