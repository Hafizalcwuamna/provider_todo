import 'package:flutter/material.dart';
import 'package:pkg_provider/models/todo.dart';
import 'package:pkg_provider/todo_controller.dart';
import 'package:provider/provider.dart';

import 'edit_todo_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.currentIndex,
    required this.todo,
  }) : super(key: key);

  final int currentIndex;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('${currentIndex + 1}'),
        actions: [
          IconButton(
            onPressed: () {
              provider.deleteTodo(currentIndex);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoPage(
                    currentIndex: currentIndex,
                    todo: todo,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: provider,
        builder: (context, child) {
          if (provider.todos.isNotEmpty) {
            final currentTodo = provider.todos[currentIndex];
            return ListTile(
              title: Text(currentTodo.task!),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
