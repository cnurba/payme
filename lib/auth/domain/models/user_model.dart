import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String login;
  final String email;
  final List<String> roles;

  const UserModel({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      login: json['login'] ?? '',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      login: '',
      email: '',
      roles: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'email': email,
      'roles': roles,
    };
  }

  @override
  List<Object?> get props => [id, name, login, email, roles];
}
