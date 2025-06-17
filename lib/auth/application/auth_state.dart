import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isLoggedIn;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isLoggedIn = false,
  });

  AuthState copyWith({String? email, String? password, bool? isLoggedIn}) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [email, password, isLoggedIn];
}
