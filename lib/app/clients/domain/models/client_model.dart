import 'package:equatable/equatable.dart';

class ClientModel extends Equatable {
  final String uuid;
  final String name;

  const ClientModel({required this.uuid, required this.name});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(uuid: json['uuid'] ?? "", name: json['name'] ?? "");
  }

  @override
  List<Object?> get props => [uuid, name];
}
