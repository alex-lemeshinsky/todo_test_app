import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app/models/task.dart';
import 'package:todo_test_app/providers/tasks_provider.dart';
import 'package:todo_test_app/widgets/bottom_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _submitButtonDisabled = false;
  DateTime? pickedDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _submitButtonDisabled = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter correct data')),
      );
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => setState(() {
          _submitButtonDisabled = false;
        }),
      );
    } else {
      context.read<TasksProvider>().addTask(
            Task(
              id: DateTime.now().millisecondsSinceEpoch,
              title: _titleController.text,
              due_on: pickedDate!.toIso8601String(),
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add task"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Deadline",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    readOnly: true,
                    controller: _deadlineController,
                    onTap: () async {
                      pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2023),
                      );
                      if (pickedDate != null) {
                        _deadlineController.text =
                            "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please pick date";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            BottomButton(
              title: "Create a Task",
              onTap: _submitButtonDisabled ? null : _submitForm,
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
