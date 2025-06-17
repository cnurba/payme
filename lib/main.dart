import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/injection.dart';
import 'package:payme/run_payme_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(ProviderScope(child: const PayMeApp()));
}

_init() async {
  initDependencies();
}
