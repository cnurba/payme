// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BlockModel extends Equatable {
  final String uuid;
  final String name;
  const BlockModel({required this.uuid, required this.name});

  BlockModel copyWith({String? uuid, String? name}) {
    return BlockModel(uuid: uuid ?? this.uuid, name: name ?? this.name);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uuid, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uuid': uuid, 'name': name};
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(uuid: map['uuid'] as String, name: map['name'] as String);
  }

  String toJson() => json.encode(toMap());

}
