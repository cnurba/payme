import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/domain/models/order_item.dart';
import 'package:payme/app/products/domain/models/product.dart';

class OrdersController extends StateNotifier<List<OrderItem>> {
  /// Creates a NewOrderController with an initial state.
  OrdersController() : super(([]));

  /// Login function with _api.
  Future<void> addProduct(Product product, int count, bool isCounter) async {
    final sProduct = OrderItem(product: product, count: count);

    /// Check if the product already exists in the state
    /// If it exists, update the count and amount
    /// If it does not exist, add it to the state
    final existingProductIndex = state.indexWhere(
      (s) => s.product.uuid == product.uuid,
    );
    if (existingProductIndex != -1) {
      // Product already exists, update the count and amount
      final existingProduct = state[existingProductIndex];

      var updatedProduct;

      if (!isCounter) {
        /// if is counter, set count to 1
        updatedProduct = existingProduct.copyWith(
          count: count,
        );

      } else {
        /// if is not counter, set count to the value passed
        bool isAdd = true;
        if (existingProduct.count > count) {
          isAdd = false;
        }

        updatedProduct = existingProduct.copyWith(
          count: isAdd ? existingProduct.count + 1 : existingProduct.count - 1,

        );
      }

      state = [
        ...state.sublist(0, existingProductIndex),
        updatedProduct,
        ...state.sublist(existingProductIndex + 1),
      ];

      /// if summ of all products is 0, remove the product from the state
      if (updatedProduct.count <= 0) {
         state = [
          ...state.sublist(0, existingProductIndex),
          ...state.sublist(existingProductIndex + 1),
        ];
      }
    } else {
      state = [...state, sProduct];
    }
  }

  void clearSelectedProducts() {
     state = [];
  }

  void removeProduct(String uuid) {

    state = state.where((s) => s.product.uuid != uuid).toList();
  }
}
