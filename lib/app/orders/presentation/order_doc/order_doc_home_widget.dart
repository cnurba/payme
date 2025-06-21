import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';
import '../../application/order_doc/order_doc_provider.dart';

class OrderDocHomeWidget extends ConsumerWidget {
  const OrderDocHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(orderDocProvider);

    return resultAsync.when(
      data: (orderDocs) {
        return HomeMenuWidget(
          bgColor: Colors.pinkAccent,
          buttonText: "Перейти",
          countText: "Активные",
          title: 'Мои \nзаявки',
          description: "Не утверженные\nзаявки",
          count: orderDocs.length,
          onTap: () {
             context.push(OrderDocScreen(orderDocs: orderDocs));
          },
        );
      },
      error: (e, s) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
