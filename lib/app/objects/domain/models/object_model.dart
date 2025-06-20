// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:payme/app/objects/domain/models/block_model.dart';

class ObjectModel extends Equatable {
  final String uuid;
  final String name;
  final List<BlockModel> blocks;
  const ObjectModel({required this.uuid, required this.name,required this.blocks });

  @override
  List<Object?> get props => [uuid, name];

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      blocks:(json['blocks'] as List)
          .map((block) => BlockModel.fromMap(block))
          .toList(),
      uuid: json['uuid'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      'blocks': blocks.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ObjectModel.empty() {
    return const ObjectModel(uuid: '', name: '', blocks: []);
  }
}
