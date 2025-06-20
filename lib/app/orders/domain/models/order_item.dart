import 'package:equatable/equatable.dart';
import 'package:payme/app/expances/domain/models/expance.dart';
import 'package:payme/app/products/domain/models/product.dart';

class OrderItem extends Equatable {
  final Product product;
  final int count;
  final Expanse? expense;

  const OrderItem({required this.product, required this.count, this.expense});

  /// copyWith method to create a new instance with modified properties
  OrderItem copyWith({
    Product? product,
    int? count,
    Expanse? expense,
  }) {
    return OrderItem(
      product: product ?? this.product,
      count: count ?? this.count,
      expense: expense ?? this.expense,
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: Product.fromJson(json['product']),
      count: json['count'] ?? 0,
      expense:
          json['expense'] != null ? Expanse.fromJson(json['expense']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'count': count,
      'expense':expense==null?{
        "name": "",
        "uuid": "",
      }:expense?.toJson(),
    };
  }

  @override
  List<Object?> get props => [product, count, expense];
}
