import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/brands/domain/repositories/i_brand_repository.dart';
import 'package:payme/app/brands/infrastructure/repositories/brand_repository.dart';
import 'package:payme/app/tasks/domain/repositories/i_task_repository.dart';
import 'package:payme/app/tasks/infrastructure/repositories/task_repository.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/injection.dart';

final tasksRepositoryProvider = Provider<ITaskRepository>(
  (ref) => TaskRepository(getIt<Dio>(), getIt<ISecureStorage>()),
);

final myTaskFutureProvider = FutureProvider.autoDispose<ApiResult>((ref) async {
  final brandRepository = ref.watch(tasksRepositoryProvider);
  final result = await brandRepository.getMyTasks();
  return result;
});
