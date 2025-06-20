import 'package:payme/app/orders/domain/models/order_model.dart';

abstract class IOrderRepository {
  /// Fetches a list of units.
  Future<bool> addOrder(OrderModel order);
}
