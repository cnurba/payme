import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/new_orders/new_order_controller.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/injection.dart';

final newOrderProvider = StateNotifierProvider<NewOrderController, OrderModel>(
      (ref) => NewOrderController(getIt<IOrderRepository>()),
);
