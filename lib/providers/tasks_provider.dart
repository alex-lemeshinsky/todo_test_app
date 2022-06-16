import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:todo_test_app/models/task.dart';
import 'package:http/http.dart' as http;

class TasksProvider extends ChangeNotifier {
  late List<Task> _tasks;

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks =>
      _tasks.where((task) => task.completed).toList();
  List<Task> get uncompletedTasks =>
      _tasks.where((task) => !task.completed).toList();

  Future<void> downloadTasks() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _tasks = [];
      throw Exception("No internet connection");
    }

    final response = await http.get(
      Uri.parse("https://gorest.co.in/public/v2/todos"),
    );
    final List<dynamic> decodedData = jsonDecode(response.body);

    _tasks = decodedData.map((jsonData) => Task.fromJson(jsonData)).toList();
    notifyListeners();
  }

  void changeTaskStatus(int id) {
    _tasks.firstWhere((task) => task.id == id).changeStatus();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  List<Task> searchTask(String query) {
    return _tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  bool getTaskStatus(int id) {
    return _tasks.firstWhere((task) => task.id == id).completed;
  }
}
