import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/orders/orders_provider.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProducts = ref.watch(orderItemProvider);
    if (selectedProducts.isEmpty) {
      return SizedBox.shrink();
    }
    final totalCount = selectedProducts.fold<double>(
      0,
      (previousValue, element) => previousValue + element.count,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.shopping_basket, color: Colors.green, size: 24),
            Text(
              '${totalCount.round()}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            //SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
