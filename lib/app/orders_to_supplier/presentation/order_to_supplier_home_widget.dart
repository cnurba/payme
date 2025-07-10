import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/app/orders_to_supplier/application/order_to_supplier_provider.dart';
import 'package:payme/app/orders_to_supplier/presentation/order_to_supplier_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';

class OrderToSupplierHomeWidget extends ConsumerWidget {
  const OrderToSupplierHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(orderToSupplierProvider);
    return resultAsync.when(
      data: (orderDocs) {
        return HomeMenuWidget(
          bgColor: Colors.green,
          buttonText: "Перейти",
          countText: "Активные",
          title: 'Заказы\nпоставщикам',
          description: "Оформить\nзаказы поставщикам",
          count: orderDocs.length,
          onTap: () {
            context.push(
              OrderToSupplierScreen(
                ordersToSuppliers: orderDocs,
              ),
            );
          },
        );
      },
      error: (e, s) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
