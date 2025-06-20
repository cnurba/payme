import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/floors/domain/repositories/i_floor_repository.dart';
import 'package:payme/app/floors/infrastructure/repositories/floor_repository.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final floorRepoProvider = Provider<IFloorRepository>(
  (ref) => FloorRepository(getIt<Dio>()),
);

final floorProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final rRepo = ref.watch(floorRepoProvider);
  final result = await rRepo.fetchFloors();
  return result;
});
