import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders/application/order_doc/order_doc_provider.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc_history.dart';

final orderDocHistoryProvider = FutureProvider.autoDispose
    .family<List<OrderDocHistory>, String>((ref, uuid) async {
      final _repo = ref.watch(orderRepositoryProvider);
      final result = await _repo.getOrderDocHistory(uuid);
      return result;
    });
