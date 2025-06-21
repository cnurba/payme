import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/order_doc/order_doc_history_provider.dart';

class OrderDocHistoryScreen extends StatelessWidget {
  const OrderDocHistoryScreen({super.key, required this.uuid});
  final String uuid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История заявки'),
        actions: [

        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final orderDocHistoryAsync = ref.watch(orderDocHistoryProvider(uuid));
          return orderDocHistoryAsync.when(
            data: (orderDocHistories) {
              if (orderDocHistories.isEmpty) {
                return Center(child: Text("Нет данные для отображения"));
              }
              return ListView.builder(
                itemCount: orderDocHistories.length,
                itemBuilder: (context, index) {
                  final orderDocHistory = orderDocHistories[index];
                  final theme = Theme.of(context);
                  return Card(
                    color: theme.cardColor,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            orderDocHistory.done
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                        child: Icon(
                          orderDocHistory.done ? Icons.check : Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              orderDocHistory.point,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            orderDocHistory.date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (orderDocHistory.comment.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              orderDocHistory.comment,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                orderDocHistory.executorName,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (e, s) => Center(child: Text("Ошибка загрузки данных")),
            loading: () => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
