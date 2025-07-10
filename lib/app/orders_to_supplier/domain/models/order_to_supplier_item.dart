import 'package:equatable/equatable.dart';

class OrderToSupplierItem extends Equatable {
  final String productName;
  final double count;
  final String productUuid;
  final String orderUuid;

  const OrderToSupplierItem({
    required this.productName,
    required this.count,
    required this.productUuid,
    required this.orderUuid,
  });

  /// copyWith method to create a new instance with modified properties
  OrderToSupplierItem copyWith({
    String? productName,
    double? count,
    String? productUuid,
    String? orderUuid,
  }) {
    return OrderToSupplierItem(
      productName: productName ?? this.productName,
      count: count ?? this.count,
      productUuid: productUuid ?? this.productUuid,
      orderUuid: orderUuid ?? this.orderUuid,
    );
  }

  factory OrderToSupplierItem.fromJson(Map<String, dynamic> json) {
    return OrderToSupplierItem(
      productName: json['productName'] ?? '',
      count: json['count'] ?? 0,
      productUuid: json['productUuid'] ?? '',
      orderUuid: json['orderUuid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'productName': productName, 'count': count, 'productUuid': productUuid, 'orderUuid': orderUuid};
  }

  @override
  List<Object?> get props => [productName, count, productUuid,orderUuid];
}
