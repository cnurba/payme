import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/app/tasks/application/task_done_provider.dart';
import 'package:payme/app/tasks/domain/models/task.dart';
import 'package:payme/app/tasks/domain/models/task_item.dart';
import 'package:payme/core/presentation/messages/messenger.dart';
import 'package:payme/core/presentation/messages/show_center_message.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final Task task;
  final VoidCallback? onDone;

  const TaskDetailScreen( {super.key, required this.task,this.onDone});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskActionScreenState();
}

class _TaskActionScreenState extends ConsumerState<TaskDetailScreen>
    with TickerProviderStateMixin {
  final TextEditingController _resultController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _resultController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onDone() async {
    final params = TaskActionParams(
      uuid: widget.task.uuid,
      isDone: true,
      result: _resultController.text,
    );
    final result1 = await ref.read(taskActionProvider(params).future);

    if (result1) {
      showSuccessMessage(context, 'Задача успешно cогласована');
      Navigator.of(context).pop(true); // Закрыть экран после успешного выполнения
      widget.onDone?.call(); // Вызвать коллбэк, если он задан
      return;
    }

    showCenteredErrorMessage(context, 'Не удалось согласовать задачу');
  }

  void _onReject() async {
    if (_resultController.text.isEmpty) {
      showCenteredErrorMessage(context, 'Пожалуйста, введите результат отказа');
      return;
    }
    final params = TaskActionParams(
      uuid: widget.task.uuid,
      isDone: false,
      result: _resultController.text,
    );

    final result1 = await ref.read(taskActionProvider(params).future);

    if (result1) {
      showSuccessMessage(context, 'Задача успешно отклонена');
      Navigator.of(context).pop(true); // Закрыть экран после успешного выполнения
      widget.onDone?.call();
      return;
    }

    showCenteredErrorMessage(context, 'Не удалось отклонить задачу');
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          tabs: const [Tab(text: 'Задача'), Tab(text: 'Товары')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: Основная задача
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              _buildInfoCard(Icons.warning, 'Срочность', task.urgent),
              _buildInfoCard(Icons.calendar_today, 'Дедлайн', task.dedline),
              _buildInfoCard(Icons.info_outline, 'Статус', task.status),
              _buildInfoCard(Icons.location_on, 'Объект', task.object),
              _buildInfoCard(
                Icons.attach_money,
                'Тип расходов',
                task.expencesType,
              ),
              _buildInfoCard(
                Icons.apartment,
                'Этаж / Блок',
                '${task.floor} / ${task.blok}',
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _resultController,
                decoration: const InputDecoration(
                  labelText: 'Результат согласования или отказа',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FloatingActionButton.extended(
                      onPressed: _onReject,
                      icon: const Icon(Icons.close),
                      label: const Text('Отказать'),
                      backgroundColor: Colors.redAccent,
                      heroTag: 'rejectBtn',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FloatingActionButton.extended(
                      onPressed: _onDone,
                      icon: const Icon(Icons.check),
                      label: const Text('Согласовать'),
                      backgroundColor: Colors.teal,
                      heroTag: 'doneBtn',
                    ),
                  ),
                ],
              ),
            ],
          ),
          // TAB 2: Список товаров
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children:
                  task.products.map((item) => _buildProductTile(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        dense: true,
        // делает плитку ниже
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        leading: Icon(icon, color: Colors.teal, size: 22),
        title: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 13)),
      ),
    );
  }

  Widget _buildProductTile(TaskItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag, color: Colors.indigo),
        title: Text(item.product),
        trailing: Text('${item.count} ${item.unit}'),
      ),
    );
  }
}
