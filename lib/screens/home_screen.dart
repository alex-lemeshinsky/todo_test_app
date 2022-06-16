import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app/providers/tasks_provider.dart';
import 'package:todo_test_app/screens/add_task_screen.dart';
import 'package:todo_test_app/widgets/bottom_button.dart';
import 'package:todo_test_app/widgets/custom_page_route.dart';
import 'package:todo_test_app/widgets/search_delegate.dart';
import 'package:todo_test_app/widgets/tasks_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Board"),
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MainSearchDelegate()),
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Completed"),
              Tab(text: "Uncompleted"),
            ],
          ),
        ),
        body: FutureBuilder(
          future: context.read<TasksProvider>().downloadTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  TabBarView(
                    children: [
                      TasksList(
                        tasks: context.watch<TasksProvider>().tasks,
                      ),
                      TasksList(
                        tasks: context.watch<TasksProvider>().completedTasks,
                      ),
                      TasksList(
                        tasks: context.watch<TasksProvider>().uncompletedTasks,
                      ),
                    ],
                  ),
                  snapshot.hasError &&
                          context.read<TasksProvider>().tasks.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Text(
                              "You do not have an internet connection, but you can work with application in offline mode",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  Positioned.fill(
                    bottom: 45,
                    child: BottomButton(
                      title: "Add a task",
                      onTap: () => Navigator.push(
                        context,
                        CustomPageRoute(child: const AddTaskScreen()),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
