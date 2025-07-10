import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/orders/orders_provider.dart';
import 'package:payme/app/orders_to_supplier/application/orders_to_supplier/orders_to_supplier_provider.dart';

class OrderToSupplierCard extends ConsumerWidget {
  const OrderToSupplierCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems = ref.watch(orderToSupplierItemProvider);
    if (selectedItems.isEmpty) {
      return SizedBox.shrink();
    }
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
              '${selectedItems.length}',
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
