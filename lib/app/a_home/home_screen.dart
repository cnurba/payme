import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/presentation/brands_menu_widget.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_all_home_widget.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_home_widget.dart';
import 'package:payme/app/orders_for_acceptance/application/order_acceptance_provider.dart';
import 'package:payme/app/orders_for_acceptance/presentation/order_for_acceptancel_home_widget.dart';
import 'package:payme/app/orders_to_supplier/application/order_to_supplier_provider.dart';

import 'package:payme/app/orders_to_supplier/presentation/order_to_supplier_home_widget.dart';
import 'package:payme/app/products/presentation/products_screen.dart';

import 'package:payme/app/tasks/presentation/task_home_widget.dart';
import 'package:payme/auth/application/auth_provider.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/theme/theme_provider.dart';

import '../../auth/application/current_user_provider.dart';
import '../reports/presentation/report_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(ProductsScreen());
        },
        tooltip: 'Создать заказ',
        child: const Icon(Icons.add),
      ),
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
      body: Consumer(
        builder: (context, ref, child) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(orderToSupplierProvider);
              ref.refresh(orderAcceptanceProvider);
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                BrandsHomeWidget(),
                TaskHomeWidget(),
                OrderDocHomeWidget(),
                OrderForAcceptanceHomeWidget(),
                OrderToSupplierHomeWidget(),
                OrderDocAllHomeWidget(),
                ReportHomeWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
