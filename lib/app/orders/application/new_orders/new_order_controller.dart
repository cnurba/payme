import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/floors/domain/models/floor_model.dart';
import 'package:payme/app/objects/domain/models/block_model.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/app/orders/domain/models/order/order_item.dart';
import 'package:payme/app/orders/domain/models/order/order_model.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';

class NewOrderController extends StateNotifier<OrderModel> {
  /// Creates a NewOrderController with an initial state.
  NewOrderController(this._orderRepository) : super((OrderModel.empty()));

  final IOrderRepository _orderRepository;

  get object => state.object;

  void addOrderItem(List<OrderItem> orderItem) {
    state = state.copyWith(items: orderItem);
  }

  /// fill client.
  void setComment({required String comment}) {
    state = state.copyWith(description: comment);
  }

  /// set date
  void setDate({required DateTime date}) {
    state = state.copyWith(expiryDateAt: date);
  }

  ///set important
  void setImportant({required bool isImportant}) {
    state = state.copyWith(isImportant: isImportant);
  }

  /// fill expense.
  void fillExpense({required String expenseName, required String expenseUuid}) {
    state = state.copyWith(expenseName: expenseName, expenseUuid: expenseUuid);
  }

  /// fill object.
  void setObject(ObjectModel object) {
    state = state.copyWith(object: object);
  }

  /// fill block.
  void setBlock(BlockModel block) {
    state = state.copyWith(blockUuid: block.uuid, name: block.name);
  }

  /// fill floor.
  void setFloor(FloorModel floor) {
    state = state.copyWith(floorUuid: floor.uuid, floorName: floor.name);
  }

  Future<bool> createOrder() async {
    final result = await _orderRepository.addOrder(state);
    if (result) {
      state = OrderModel.empty();
      return true;
    }
    return false;
  }
}
