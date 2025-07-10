import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/app/orders_for_acceptance/domain/repositories/i_order_for_acceptance_repository.dart';
import 'package:payme/app/orders_for_acceptance/infrastructure/order_for_acceptance_repository.dart';
import 'package:payme/app/orders_to_supplier/domain/models/order_to_supplier.dart';
import 'package:payme/app/orders_to_supplier/domain/repositories/i_order_to_supplier_repository.dart';
import 'package:payme/app/orders_to_supplier/infrastructure/order_to_supplier_repository.dart';
import 'package:payme/injection.dart';

final orderSupplierRepositoryProvider =
    Provider<IOrderToSupplierRepository>(
      (ref) => OrderToSupplierRepository(getIt<Dio>()),
    );

final orderToSupplierProvider =
    FutureProvider.autoDispose<List<OrderToSupplier>>((ref) async {
      final _repo = ref.watch(orderSupplierRepositoryProvider);
      final result = await _repo.getAllForSupplier();
      return result;
    });

