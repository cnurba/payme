import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/orders/orders_controller.dart';
import 'package:payme/app/orders/domain/models/order/order_item.dart';

final orderItemProvider = StateNotifierProvider<OrdersController, List<OrderItem>>(
      (ref) => OrdersController(),
);
