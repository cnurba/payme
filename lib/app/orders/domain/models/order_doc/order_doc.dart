import 'package:equatable/equatable.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_item.dart';

class OrderDoc extends Equatable {
  final String uuid;
  final String name;
  final String objectName;
  final String blockName;
  final String floorName;
  final String expanceName;
  final String status;
  final String comment;
  final String deadline;
  final String createdAt;
  final String number;
  final String authorName;
  final List<OrderDocItem> items;

  const OrderDoc({
    required this.uuid,
    required this.name,
    required this.objectName,
    required this.blockName,
    required this.floorName,
    required this.expanceName,
    required this.status,
    required this.comment,
    required this.deadline,
    required this.createdAt,
    required this.number,
    required this.authorName,
    this.items = const [],
  });

  factory OrderDoc.fromJson(Map<String, dynamic> json) {
    return OrderDoc(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      objectName: json['objectName'] ?? '',
      blockName: json['blockName'] ?? '',
      floorName: json['floorName'] ?? '',
      expanceName: json['expanceName'] ?? '',
      status: json['status'] ?? '',
      comment: json['comment'] ?? '',
      deadline: json['deadline'] ?? '',
      createdAt: json['createdAt'] ?? '',
      number: json['number'] ?? '',
      authorName: json['authorName'] ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => OrderDocItem.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
    uuid,
    name,
    objectName,
    blockName,
    floorName,
    expanceName,
    status,
    comment,
    deadline,
    createdAt,
    number,
    authorName,
    items,
  ];
}
