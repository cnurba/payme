import 'package:equatable/equatable.dart';

class UnitModel extends Equatable{
  final String uuid;
  final String name;
  const UnitModel({
    required this.uuid,
    required this.name,

  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      uuid: json['uuid'] ??"",
      name: json['name'] ??"",
    );
  }

  @override
  List<Object?> get props => [uuid, name];
}