import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/domain/models/order/order_item.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier_item.dart';
import 'package:payme/app/products/domain/models/product.dart';

class OrderToSupplierController
    extends StateNotifier<List<OrderToSupplierItem>> {
  /// Creates a NewOrderController with an initial state.
  OrderToSupplierController() : super(([]));

  /// Login function with _api.
  Future<void> add(OrderToSupplier orderToSupplier) async {
    final orderToSupplierItem = OrderToSupplierItem(
      productUuid: orderToSupplier.productUuid,
      productName: orderToSupplier.productName,
      count: orderToSupplier.count,
      orderUuid: orderToSupplier.uuid,
    );

    /// check if the item already exists
    /// field `uuid` and productName are used to identify the item
    /// if it does, update the count
    /// if it doesn't, add it to the list

    final existingItemIndex = state.indexWhere(
      (item) =>
          item.productUuid == orderToSupplierItem.productUuid &&
          item.productName == orderToSupplierItem.productName && orderToSupplierItem.orderUuid == item.orderUuid,
    );
    if (existingItemIndex != -1) {
      // If the item exists, don't add it again
      return;
    }
    // If the item does not exist, add it to the list
    // This is a new item, so we can add it to the list
    if (orderToSupplierItem.count <= 0) {
      // If the count is less than or equal to 0, do not add it
      return;
    }
    // Add the new item to the state
    state = [...state, orderToSupplierItem];
  }

  void clear() {
    state = [];
  }

  void remove(String uuid) {}
}
