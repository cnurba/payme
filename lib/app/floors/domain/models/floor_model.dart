import 'package:equatable/equatable.dart';

class FloorModel extends Equatable {
  final String uuid;
  final String name;
  const FloorModel({required this.uuid, required this.name});

  factory FloorModel.fromJson(Map<String, dynamic> json) {
    return FloorModel(uuid: json['uuid'] ?? "", name: json['name'] ?? "");
  }

  @override
  List<Object?> get props => [uuid, name];
}
