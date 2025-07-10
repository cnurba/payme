import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/app/orders_for_acceptance/application/order_acceptance_provider.dart';
import 'package:payme/app/orders_for_acceptance/presentation/order_acceptance_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/presentation/messages/messenger.dart';

class OrderForAcceptanceHomeWidget extends ConsumerWidget {
  const OrderForAcceptanceHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(orderAcceptanceProvider);

    return resultAsync.when(
      data: (orderDocs) {
        return HomeMenuWidget(
          bgColor: Colors.blue,
          buttonText: "Перейти",
          countText: "Активные",
          title: 'Заявки\nна обработку',
          description: "Принять заявки на\nобработку",
          count: orderDocs.length,
          onTap: () {
            context.push(
              OrderAcceptanceScreen(
                orderAcceptances: orderDocs,
                onAccept: (order) async {
                  final result1 = await ref.read(
                    orderAcceptancePostProvider(order).future,
                  );
                  if (result1 != false) {
                    showSuccessMessage(context, 'Заявка успешно принята');
                    Future.delayed(const Duration(seconds: 1), () {
                      ref.refresh(orderAcceptanceProvider);
                    });
                    return;
                  }
                },
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
