import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/tasks/application/my_tasks_future_provider.dart';
import 'package:payme/core/failure/app_result.dart';

class TaskActionParams {
  final String uuid;
  final bool isDone;
  final String result;

  const TaskActionParams({
    required this.uuid,
    required this.isDone,
    required this.result,
  });
}

final taskActionProvider = FutureProvider.autoDispose
    .family<bool, TaskActionParams>((ref, params) async {
      final repo = ref.watch(tasksRepositoryProvider);

      ApiResult result;
      if (params.isDone) {
        result = await repo.done(params.uuid, params.result);
      } else {
        result = await repo.reject(params.uuid, params.result);
      }

      if (result is ApiResultWithData) {
        ref.refresh(myTaskFutureProvider);
        return true;
      } else {
        return false;
      }
    });
