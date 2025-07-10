import 'package:flutter/material.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_history_screen.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/core/extensions/route_extension.dart';

class OrderAcceptanceScreen extends StatefulWidget {
  const OrderAcceptanceScreen({
    super.key,
    required this.orderAcceptances,
    required this.onAccept,
  });

  final List<OrderForAcceptance> orderAcceptances;
  final Function(OrderForAcceptance order) onAccept;

  @override
  State<OrderAcceptanceScreen> createState() => _OrderAcceptanceScreenState();
}

class _OrderAcceptanceScreenState extends State<OrderAcceptanceScreen> {
  List<OrderForAcceptance> orderAcceptances = [];

  @override
  void initState() {
    orderAcceptances = [...widget.orderAcceptances];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(title: Text("Заявки для обработки")),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder:
            (context, index) =>
                Divider(color: theme.dividerColor, height: 1, thickness: 1),
        itemCount: orderAcceptances.length,
        itemBuilder: (context, index) {
          final doc = orderAcceptances[index];
          return ListTile(
            trailing: IconButton(
              onPressed: () {
                widget.onAccept(doc);
                orderAcceptances.removeAt(index);
                setState(() {});
              },
              icon: Icon(Icons.check_circle_outline, color: Colors.green),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doc.productName.trim(),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                Text('Автор: ${doc.authorName}', style: textTheme.bodyMedium),
              ],
            ),
          );
        },
      ),
    );
  }
}
