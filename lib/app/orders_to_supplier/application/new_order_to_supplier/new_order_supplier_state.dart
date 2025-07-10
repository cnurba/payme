import 'package:equatable/equatable.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier_item.dart';

class NewOrderToSupplierState extends Equatable {
  final String clientUuid;
  final String clientName;
  final List<OrderToSupplierItem> items;

  const NewOrderToSupplierState({
    required this.clientUuid,
    required this.clientName,
    required this.items,
  });

  factory NewOrderToSupplierState.empty() {
    return NewOrderToSupplierState(clientUuid: '', clientName: '', items: []);
  }

  NewOrderToSupplierState copyWith({
    String? clientUuid,
    String? clientName,
    List<OrderToSupplierItem>? items,
  }) {
    return NewOrderToSupplierState(
      clientUuid: clientUuid ?? this.clientUuid,
      clientName: clientName ?? this.clientName,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [clientUuid, clientName, items];

  toJson() {
    return {
      'clientUuid': clientUuid,
      'clientName': clientName,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
