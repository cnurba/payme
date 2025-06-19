import 'package:equatable/equatable.dart';

class TaskItem extends Equatable {
  final String product;
  final String unit;
  final int count;

  const TaskItem({
    required this.product,
    required this.unit,
    required this.count,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      product: json['product'] ?? '',
      unit: json['unit'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [product, unit, count];
}