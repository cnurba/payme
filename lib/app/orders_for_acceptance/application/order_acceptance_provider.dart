import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/orders_for_acceptance/domain/models/order_for_acceptance.dart';
import 'package:payme/app/orders_for_acceptance/domain/repositories/i_order_for_acceptance_repository.dart';
import 'package:payme/app/orders_for_acceptance/infrastructure/order_for_acceptance_repository.dart';
import 'package:payme/injection.dart';

final orderAcceptanceRepositoryProvider =
    Provider<IOrderForAcceptanceRepository>(
      (ref) => OrderForAcceptanceRepository(getIt<Dio>()),
    );

final orderAcceptanceProvider =
    FutureProvider.autoDispose<List<OrderForAcceptance>>((ref) async {
      final _repo = ref.watch(orderAcceptanceRepositoryProvider);
      final result = await _repo.getAllForAcceptance();
      return result;
    });

final orderAcceptancePostProvider = FutureProvider.autoDispose
    .family<bool, OrderForAcceptance>((ref, order) async {
      final _repo = ref.watch(orderAcceptanceRepositoryProvider);
      final result = await _repo.createAcceptance(order);
      if (result == false) {
        throw Exception("Failed to create order acceptance");
      }

      log("Order acceptance created successfully");
      return result;
    });
