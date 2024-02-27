import 'package:flutter/material.dart';
import 'package:pkg_provider/models/todo.dart';
import 'package:pkg_provider/todo_controller.dart';
import 'package:provider/provider.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({
    Key? key,
    required this.currentIndex,
    required this.todo,
  }) : super(key: key);

  final int currentIndex;
  final Todo todo;

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskController.text = widget.todo.task!;
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Task is empty';
                  } else {
                    return null;
                  }
                },
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'Edit your task',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final formKey = _formKey.currentState;
                if (formKey != null && formKey.validate()) {
                  formKey.save();
                  provider.updateTodo(
                    widget.currentIndex,
                    Todo(task: taskController.text),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
