import 'package:equatable/equatable.dart';
import 'package:payme/app/objects/domain/models/object_model.dart';
import 'package:payme/app/orders/domain/models/order/order_item.dart';
import 'package:payme/core/extensions/date_extensions.dart';

class OrderModel extends Equatable {
  final String authorName;
  final String expenseName;
  final String expenseUuid;
  final ObjectModel object;
  final String blockUuid;
  final String blockName;
  final String floorName;
  final String floorUuid;
  final DateTime createdAt;
  final DateTime expiryDateAt;
  final String uuid;
  final String name;
  final String description;
  final bool isImportant;
  final List<OrderItem> items;

  const OrderModel({
    required this.expenseName,
    required this.expenseUuid,
    required this.object,
    required this.blockUuid,
    required this.blockName,
    required this.floorName,
    required this.floorUuid,
    required this.createdAt,
    required this.expiryDateAt,
    required this.uuid,
    required this.name,
    required this.description,
    required this.isImportant,
    required this.items,
    this.authorName = '',
  });

  factory OrderModel.empty() {
    return OrderModel(
      expenseName: '',
      expenseUuid: '',
      object: ObjectModel.empty(),
      blockUuid: '',
      blockName: '',
      floorName: '',
      floorUuid: '',
      createdAt: DateTime.now(),
      expiryDateAt: DateTime.now(),
      uuid: '',
      name: '',
      description: '',
      isImportant: false,
      items: [],
    );
  }

  @override
  List<Object?> get props => [
    expenseName,
    expenseUuid,
    object,
    blockUuid,
    blockName,
    floorName,
    floorUuid,
    createdAt,
    expiryDateAt,
    uuid,
    name,
    description,
    isImportant,
    items,
    authorName
  ];

  OrderModel copyWith({
    String? expenseName,
    String? expenseUuid,
    ObjectModel? object,
    String? objectName,
    String? blockUuid,
    String? blockName,
    String? floorName,
    String? floorUuid,
    DateTime? createdAt,
    DateTime? expiryDateAt,
    String? uuid,
    String? name,
    String? description,
    bool? isImportant,
    List<OrderItem>? items,
  }) {
    return OrderModel(
      expenseName: expenseName ?? this.expenseName,
      expenseUuid: expenseUuid ?? this.expenseUuid,
      object: object ?? this.object,
      blockUuid: blockUuid ?? this.blockUuid,
      blockName: blockName ?? this.blockName,
      floorName: floorName ?? this.floorName,
      floorUuid: floorUuid ?? this.floorUuid,
      createdAt: createdAt ?? this.createdAt,
      expiryDateAt: expiryDateAt ?? this.expiryDateAt,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      isImportant: isImportant ?? this.isImportant,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseName': expenseName,
      'expenseUuid': expenseUuid,
      'objectName': object.name,
      'objectUuid': object.uuid,
      'blockUuid': blockUuid,
      'blockName': blockName,
      'floorName': floorName,
      'floorUuid': floorUuid,
      'createdAt': createdAt.toIso8601String(),
      'expiryDateAt': expiryDateAt.toFormattedString(),
      'uuid': uuid,
      'name': name,
      'description': description,
      'isImportant': isImportant,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      expenseName: json['expenseName'] as String,
      expenseUuid: json['expenseUuid'] as String,
      object: ObjectModel.fromJson(json['object'] as Map<String, dynamic>),

      blockUuid: json['blockUuid'] as String,
      blockName: json['blockName'] as String,
      floorName: json['floorName'] as String,
      floorUuid: json['floorUuid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiryDateAt: DateTime.parse(json['expiryDateAt'] as String),
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isImportant: json['isImportant'] ??false,
      items:
          (json['items'] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList(),
    );
  }
}
