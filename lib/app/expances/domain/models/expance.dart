import 'package:equatable/equatable.dart';

class Expanse extends Equatable {
  final String uuid;
  final String name;

  const Expanse({required this.uuid, required this.name});

  factory Expanse.fromJson(Map<String, dynamic> json) {
    return Expanse(uuid: json['uuid'] ?? '', name: json['name'] ?? '');
  }

  @override
  List<Object?> get props => [uuid, name];
}
