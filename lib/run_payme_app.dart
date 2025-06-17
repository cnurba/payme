import 'package:flutter/material.dart';
import 'package:payme/auth/presentation/login_screen.dart';

class PayMeApp extends StatelessWidget {
  const PayMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}
