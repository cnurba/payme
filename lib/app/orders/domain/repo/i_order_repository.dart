import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';

abstract class IOrderRepository {
  /// Fetches a list of units.
  Future<bool> addOrder(OrderModel order);
  Future<List<OrderDoc>> getMyOrderDocs();
  Future<List<OrderDocHistory>> getOrderDocHistory(String uuid);
}
