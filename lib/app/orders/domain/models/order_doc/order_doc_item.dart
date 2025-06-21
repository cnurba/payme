import 'package:equatable/equatable.dart';

class OrderDocItem extends Equatable {
  final String productName;
  final int count;
  final String expanceName;
  final String unitName;

  const OrderDocItem({
    required this.productName,
    required this.count,
    required this.expanceName,
    required this.unitName,
  });

  /// copyWith method to create a new instance with modified properties
  OrderDocItem copyWith({
    String? productName,
    int? count,
    String? expanceName,
    String? unitName,
  }) {
    return OrderDocItem(
      productName: productName ?? this.productName,
      count: count ?? this.count,
      expanceName: expanceName ?? this.expanceName,
      unitName: unitName ?? this.unitName,
    );
  }

  factory OrderDocItem.fromJson(Map<String, dynamic> json) {
    return OrderDocItem(
      productName: json['productName'] ?? '',
      count: json['count'] ?? 0,
      expanceName: json['expanceName'] ?? '',
      unitName: json['unitName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'count': count,
      'expanceName': expanceName,
      'unitName': unitName,
    };
  }

  @override
  List<Object?> get props => [productName, count, expanceName, unitName];


}