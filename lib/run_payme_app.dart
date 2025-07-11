import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/a_home/home_screen.dart';
import 'package:payme/auth/application/auth_provider.dart';
import 'package:payme/auth/presentation/login_screen.dart';
import 'package:payme/auth/presentation/splash_screen.dart';
import 'package:payme/core/presentation/global/restart_widget.dart';
import 'package:payme/core/theme/app_theme.dart';
import 'package:payme/core/theme/theme_provider.dart';

class PayMeApp extends ConsumerStatefulWidget {
  const PayMeApp({super.key});
  @override
  ConsumerState<PayMeApp> createState() => _PayMeAppState();
}
class _PayMeAppState extends ConsumerState<PayMeApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authControllerProvider.notifier).authCheckRequest());
  }
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    return RestartWidget(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: Consumer(
          // Using Consumer to access the context and theme
          builder: (context, ref, child) {
            // Access the auth state from the provider
            final authStateValue = ref.watch(authControllerProvider);
            return authStateValue.when(
              initial: () => const SplashScreen(),
              loading: () => const SplashScreen(),
              authenticated: () => const HomeScreen(),
              unauthenticated: () => const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
