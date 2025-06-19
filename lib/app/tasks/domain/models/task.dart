import 'package:equatable/equatable.dart';
import 'task_item.dart'; // Импортируйте TaskItem, если он в отдельном файле

class Task extends Equatable {
  final String uuid;
  final String name;
  final String urgent;
  final String dedline;
  final String status;
  final String subjectUuid;
  final String blok;
  final String floor;
  final String expencesType;
  final String object;
  final List<TaskItem> products;

  const Task({
    required this.uuid,
    required this.name,
    required this.urgent,
    required this.dedline,
    required this.status,
    required this.subjectUuid,
    required this.blok,
    required this.floor,
    required this.expencesType,
    required this.object,
    required this.products,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      urgent: json['urgent'] ?? '',
      dedline: json['dedline'] ?? '',
      status: json['status'] ?? '',
      subjectUuid: json['subjectUuid'] ?? '',
      blok: json['blok'] ?? '',
      floor: json['floor'] ?? '',
      expencesType: json['expencesType'] ?? '',
      object: json['object'] ?? '',
      products: (json['produсts'] as List<dynamic>? ?? [])
          .map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    uuid,
    name,
    urgent,
    dedline,
    status,
    subjectUuid,
    blok,
    floor,
    expencesType,
    object,
    products,
  ];
}