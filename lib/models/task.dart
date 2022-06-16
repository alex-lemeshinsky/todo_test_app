// ignore_for_file: non_constant_identifier_names

class Task {
  final int id;
  final int? user_id;
  final String title;
  final String due_on;
  bool completed;

  Task({
    required this.id,
    this.user_id,
    required this.title,
    required this.due_on,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      due_on: json["due_on"],
      completed: json["status"] == "completed",
    );
  }

  void changeStatus() {
    completed = !completed;
  }
}
