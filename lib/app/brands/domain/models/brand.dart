import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String name;
  final String uuid;
  final String description;
  final String photoUrl;

  const Brand({
    required this.name,
    required this.uuid,
    required this.description,
    required this.photoUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] ?? '',
      uuid: json['uuid'] ??"",
      description: json['description'] ??"",
      photoUrl: json['photoUrl'] ??'',
    );
  }

  @override
  List<Object?> get props => [name, uuid, description, photoUrl];
}