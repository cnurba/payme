import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String uuid;
  final String name;
  final String? description;
  final String unit;
  final String unitUuid;
  final double stock;
  final String articul;

  const Product({
    required this.uuid,
    required this.name,
    this.description,
    required this.unit,
    required this.unitUuid,
    required this.stock,
    required this.articul,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? "",
      unit: json['unit'] ?? "",
      unitUuid: json['unitUuid'] ?? '',
      stock: (json['stock'] as num).toDouble() ?? 0,
      articul: json['articul'] ??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description,
      'unit': unit,
      'unitUuid': unitUuid,
      'stock': stock,
      'articul': articul,
    };
  }


  @override
  List<Object?> get props =>
      [uuid, name, description, unit, unitUuid, stock, articul];

}
