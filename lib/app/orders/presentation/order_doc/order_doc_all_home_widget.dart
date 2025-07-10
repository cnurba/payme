import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';
import '../../application/order_doc/order_doc_provider.dart';

class OrderDocAllHomeWidget extends ConsumerWidget {
  const OrderDocAllHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(orderDocAllProvider);

    return resultAsync.when(
      data: (orderDocs) {
        return HomeMenuWidget(
          bgColor: Colors.amberAccent,
          buttonText: "Перейти",
          countText: "Активные",
          title: 'Все \nзаявки',
          description: "Все заявки\nпользователей",
          count: orderDocs.length,
          onTap: () {
             context.push(OrderDocScreen(orderDocs: orderDocs, isAll: true));
          },
        );
      },
      error: (e, s) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
