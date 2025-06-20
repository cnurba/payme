import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/tasks/application/my_tasks_future_provider.dart';
import 'package:payme/app/tasks/presentation/task_detail_screen.dart';
import 'package:payme/app/tasks/presentation/task_list_screen.dart';
import 'package:payme/app/a_home/widgets/home_menu_widget.dart';
import 'package:payme/core/extensions/route_extension.dart';
import 'package:payme/core/failure/app_result.dart';
import 'package:payme/core/presentation/messages/show_center_message.dart';

class TaskHomeWidget extends ConsumerWidget {
  const TaskHomeWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(myTaskFutureProvider);
    return resultAsync.when(
      data: (apiResult) {
        if (apiResult is ApiResultWithData) {
          final tasks = apiResult.data;
          return HomeMenuWidget(
            bgColor: Colors.lightGreen,
            buttonText: "Перейти",
            countText: tasks.length > 1 ? "Задачи" : "Задача",
            title: 'Мои \nзадачи',
            description: "Нажмите",
            count: tasks.length,
            onTap: () {
              if (tasks.isEmpty) {
                showCenteredErrorMessage(context, "Нет задач для отображения");
                return;
              }
              if (tasks.length == 1) {
                context.push(TaskDetailScreen(task: tasks.first));
              } else {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return TaskListScreen(
                      tasks: tasks,
                      onTap: (task) {
                        context.push(
                          TaskDetailScreen(
                            task: task,
                            onDone: () {
                              context.pop(true);
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        } else {
          return SizedBox.shrink();
        }
      },
      error: (e, s) => SizedBox.shrink(),
      loading: () => SizedBox.shrink(),
    );
  }
}
