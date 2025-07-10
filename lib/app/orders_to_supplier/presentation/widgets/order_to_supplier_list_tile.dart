import 'package:flutter/material.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';

class OrderToSupplierListTile extends StatelessWidget {
  const OrderToSupplierListTile({
    super.key,
    required this.onTap,
    required this.doc,
  });

  final VoidCallback onTap;
  final OrderToSupplier doc;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(Icons.add_box, color: Colors.green),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            doc.productName.trim(),
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Кол-во: ${doc.count}', style: textTheme.bodyMedium),
              SizedBox(width: 8),
              Text(doc.unitName, style: textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Объект: ${doc.objectName} / ${doc.blockName} / ${doc.floorName}',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text('Автор: ${doc.authorName}', style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
