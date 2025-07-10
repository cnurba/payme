import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/clients/domain/models/client_model.dart';
import 'package:payme/app/floors/domain/models/floor_model.dart';
import 'package:payme/app/objects/domain/models/block_model.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/app/orders/domain/models/order/order_item.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/app/orders_to_supplier/application/new_order_to_supplier/new_order_supplier_state.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier_item.dart';
import 'package:payme/app/orders_to_supplier/domain/repositories/i_order_to_supplier_repository.dart';

class NewOrderToSupplierController
    extends StateNotifier<NewOrderToSupplierState> {
  /// Creates a NewOrderController with an initial state.
  NewOrderToSupplierController(this._orderToSupplierRepository)
    : super((NewOrderToSupplierState.empty()));

  final IOrderToSupplierRepository _orderToSupplierRepository;

  void addItem(List<OrderToSupplierItem> items) {
    state = state.copyWith(items: items);
  }

  /// set client.
  ///
  void setClient({required ClientModel clientModel}) {
    state = state.copyWith(
      clientUuid: clientModel.uuid,
      clientName: clientModel.name,
    );
  }

  Future<bool> createOrderToSupplier() async {
    final result = await _orderToSupplierRepository.createOrderToSupplier(
      state.toJson(),
    );
    if (result) {
      state = NewOrderToSupplierState.empty();
      return true;
    }
    return false;
  }
}
