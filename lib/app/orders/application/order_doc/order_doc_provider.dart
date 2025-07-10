import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/app/orders/domain/models/order_doc/order_doc.dart';
import 'package:payme/app/orders/domain/repo/i_order_repository.dart';
import 'package:payme/app/orders/infrastructure/order_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final orderRepositoryProvider = Provider<IOrderRepository>(
  (ref) => OrderRepository(getIt<Dio>()),
);

final orderDocProvider = FutureProvider.autoDispose<List<OrderDoc>>((
  ref,
) async {
  final _repo = ref.watch(orderRepositoryProvider);
  final result = await _repo.getMyOrderDocs();
  return result;
});


final orderDocAllProvider = FutureProvider.autoDispose<List<OrderDoc>>((
    ref,
    ) async {
  final _repo = ref.watch(orderRepositoryProvider);
  final result = await _repo.getAllOrderDocs();
  return result;
});
