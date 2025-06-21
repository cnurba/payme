import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/presentation/brands_menu_widget.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_home_widget.dart';

import 'package:payme/app/tasks/presentation/task_home_widget.dart';
import 'package:payme/auth/application/auth_provider.dart';
import 'package:payme/core/theme/theme_provider.dart';

import '../../auth/application/current_user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider);
            return user.when(
              data: (v) => Text(v.name),
              error: (e, s) => SizedBox.shrink(),
              loading: () => SizedBox.shrink(),
            );
          },
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeNotifierProvider);
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                tooltip:
                    themeMode == ThemeMode.dark
                        ? 'Светлая тема'
                        : 'Тёмная тема',
                onPressed:
                    () =>
                        ref.read(themeNotifierProvider.notifier).toggleTheme(),
              );
            },
          ),
          Consumer(
            builder:
                (context, ref, child) => PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'signout') {
                      await ref.read(authControllerProvider.notifier).signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
                    }
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem<String>(
                          value: 'signout',
                          child: Text('Выйти'),
                        ),
                      ],
                ),
          ),
        ],
      ),
      body: ListView(
        children: [TaskHomeWidget(), OrderDocHomeWidget(), BrandsHomeWidget()],
      ),
    );
  }
}
