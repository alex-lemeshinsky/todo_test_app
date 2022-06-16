import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app/providers/tasks_provider.dart';
import 'package:todo_test_app/widgets/tasks_list.dart';

class MainSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return TasksList(tasks: context.read<TasksProvider>().searchTask(query));
  }
}
