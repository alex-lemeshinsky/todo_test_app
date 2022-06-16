import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app/constants.dart';
import 'package:todo_test_app/providers/tasks_provider.dart';
import 'package:todo_test_app/screens/home_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: MaterialApp(
        title: "ToDo app",
        home: const HomeScreen(),
        theme: ThemeData.light().copyWith(
          appBarTheme: appBarTheme,
          inputDecorationTheme: inputDecorationTheme,
        ),
      ),
    );
  }
}
