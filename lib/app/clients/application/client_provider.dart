import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/app/clients/domain/repositories/i_client_repository.dart';
import 'package:payme/app/clients/infrastructure/repositories/client_repository.dart';
import 'package:payme/app/units/domain/repositories/i_unit_repository.dart';
import 'package:payme/app/units/infrastructure/repositories/unit_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final clientRepoProvider = Provider<IClientRepository>(
  (ref) => ClientRepository(getIt<Dio>()),
);

final clientProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final rRepo = ref.watch(clientRepoProvider);
  final result = await rRepo.fetchClients();
  return result;
});
