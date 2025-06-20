import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/new_orders/new_order_provider.dart';
import 'package:payme/app/orders/application/orders/orders_provider.dart';
import 'package:payme/app/orders/presentation/order_model_screen.dart';
import 'package:payme/app/orders/presentation/widgets/order_item_card.dart';
import 'package:payme/core/extensions/route_extension.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sProducts = ref.watch(
      orderItemProvider,
    ); // Watch the selected products state
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton.icon(
            label: Text("Очистить корзину"),
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref
                  .read(orderItemProvider.notifier)
                  .clearSelectedProducts();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close,color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (sProducts.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Корзина пуста!'),
              ),
            );
            return;
          }
          ref.read(newOrderProvider.notifier).addOrderItem(sProducts);
          Navigator.pop(context);

          context.push(OrderModelScreen());


        },
        label: const Text('Оформить заказ'),
        icon: const Icon(Icons.check),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        //padding: const EdgeInsets.all(8),
        itemCount: sProducts.length, // Replace with your actual item count
        itemBuilder: (context, index) {
          return OrderItemCard(
            orderItem: sProducts.elementAt(index),
            onQuantityChanged: (quantity) {
              ref
                  .read(orderItemProvider.notifier)
                  .addProduct(sProducts.elementAt(index).product, quantity, true);
            },
            onDelete: () {
              ref
                  .read(orderItemProvider.notifier)
                  .removeProduct(sProducts.elementAt(index).product.uuid);
            },
          );
        },
      ),
    );
  }
}
