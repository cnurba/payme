import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/objects/domain/repositories/i_object_repository.dart';
import 'package:payme/app/objects/infrastructure/repositories/object_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final objectRepoProvider = Provider<IObjectRepository>(
  (ref) => ObjectRepository(getIt<Dio>()),
);

final objectProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final rRepo = ref.watch(objectRepoProvider);
  final result = await rRepo.fetchObjects();
  return result;
});
