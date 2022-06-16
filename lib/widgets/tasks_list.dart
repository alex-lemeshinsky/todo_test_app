import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_test_app/models/task.dart';
import 'package:todo_test_app/widgets/tasks_list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key, required this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: TasksListItem(task: tasks[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
