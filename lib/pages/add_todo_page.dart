import 'package:flutter/material.dart';
import 'package:pkg_provider/models/todo.dart';
import 'package:pkg_provider/todo_controller.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();

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
        title: const Text('Add Todo'),
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
                  hintText: 'Enter your task',
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
                  provider.createTodo(
                    Todo(task: taskController.text),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
