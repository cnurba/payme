import 'package:flutter/material.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/presentation/order_doc/order_doc_history_screen.dart';
import 'package:payme/core/extensions/route_extension.dart';

class OrderDocScreen extends StatelessWidget {
  const OrderDocScreen({super.key, required this.orderDocs, this.isAll = false});

  final List<OrderDoc> orderDocs;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(isAll?"Все заявки":'Мои заявки')),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: orderDocs.length,
        itemBuilder: (context, index) {
          final doc = orderDocs[index];
          return GestureDetector(
            onTap: () {
              context.push(OrderDocHistoryScreen(uuid: doc.uuid));
            },
            child: Card(
              color: theme.cardColor,
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${doc.name}',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.secondary,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text('Статус: ', style: textTheme.bodyMedium),
                        Text(
                          doc.status,
                          style: textTheme.bodyMedium?.copyWith(
                            color:
                                doc.status == 'Завершено'
                                    ? Colors.green
                                    : doc.status == 'Отклонено'
                                    ? Colors.red
                                    : theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Комментарий: ${doc.comment}',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    if (doc.items.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Позиции:',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...doc.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondary.withAlpha(
                                    20,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '• Наименование: ${item.productName}',
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      '  Кол-во: ${item.count}',
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      '  Статья: ${item.expanceName}',
                                      style: textTheme.bodySmall,
                                    ),
                                    Text(
                                      '  Ед. изм.: ${item.unitName}',
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
