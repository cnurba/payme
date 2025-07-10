import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/new_orders/new_order_controller.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/app/orders_to_supplier/application/new_order_to_supplier/new_order_supplier_state.dart';
import 'package:payme/app/orders_to_supplier/application/new_order_to_supplier/new_order_to_supplier_controller.dart';
import 'package:payme/app/orders_to_supplier/domain/repositories/i_order_to_supplier_repository.dart';
import 'package:payme/injection.dart';

final newOrderToSupplierProvider = StateNotifierProvider<NewOrderToSupplierController, NewOrderToSupplierState>(
      (ref) => NewOrderToSupplierController(getIt<IOrderToSupplierRepository>()),
);
