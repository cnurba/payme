import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:payme/app/orders_to_supplier/application/orders_to_supplier/order_to_supplier_controller.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier_item.dart';

final orderToSupplierItemProvider =
    StateNotifierProvider<OrderToSupplierController, List<OrderToSupplierItem>>(
      (ref) => OrderToSupplierController(),
    );
