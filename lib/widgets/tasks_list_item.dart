import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app/models/task.dart';
import 'package:todo_test_app/providers/tasks_provider.dart';

class TasksListItem extends StatelessWidget {
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: context.watch<TasksProvider>().getTaskStatus(task.id),
      onChanged: (newValue) =>
          context.read<TasksProvider>().changeTaskStatus(task.id),
      title: Text(task.title),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.green,
    );
  }
}
