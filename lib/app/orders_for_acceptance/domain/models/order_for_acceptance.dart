import 'package:equatable/equatable.dart';

class OrderForAcceptance extends Equatable {
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
  final String productName;
  final String productUuid;
  final double count;
  final String unitName;

  const OrderForAcceptance({
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
    required this.productName,
    required this.productUuid,
    required this.count,
    required this.unitName,
  });

  factory OrderForAcceptance.fromJson(Map<String, dynamic> json) {
    return OrderForAcceptance(
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
      productName: json['productName'] ?? '',
      productUuid: json['productUuid'] ?? '',
      count: (json['count'] as num?)?.toDouble() ?? 0.0,
      unitName: json['unitName'] ?? '',
    );
  }

  toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'objectName': objectName,
      'blockName': blockName,
      'floorName': floorName,
      'expanceName': expanceName,
      'status': status,
      'comment': comment,
      'deadline': deadline,
      'createdAt': createdAt,
      'number': number,
      'authorName': authorName,
      'productName': productName,
      'productUuid': productUuid,
      'count': count,
      'unitName': unitName,
    };
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
    productName,
    productUuid,
    count,
    unitName,
  ];
}
