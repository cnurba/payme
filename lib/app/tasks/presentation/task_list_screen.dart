import 'package:flutter/material.dart';
import 'package:payme/app/tasks/domain/models/task.dart';
import 'package:payme/app/tasks/presentation/task_card.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key, required this.tasks,required this.onTap});

  final List<Task> tasks;
  final Function(Task) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Мои задачи', style: TextStyle(color: Colors.green)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
              onTap: (){
                onTap(task);
              },
              child: TaskCard(task: task));
        },
      ),
    );
  }
}
