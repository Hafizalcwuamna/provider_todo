import 'package:flutter/material.dart';
import 'package:pkg_provider/todo_controller.dart';
import 'package:provider/provider.dart';

import 'add_todo_page.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Todos'),
        actions: [
          IconButton(
            onPressed: () {
              // provider.deleteAllTodo();

              context.read<TodoController>().deleteAllTodo();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: provider,
        builder: (context, child) {
          if (provider.todos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Add a new todo',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            );
          }
          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              final todo = provider.todos[index];
              return ListTile(
                title: Text(todo.task!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        currentIndex: index,
                        todo: todo,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoPage(),
            ),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
