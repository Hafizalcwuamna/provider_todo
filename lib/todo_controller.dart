import 'package:flutter/foundation.dart';

import 'models/todo.dart';

class TodoController with ChangeNotifier {
  final _todos = <Todo>[];

  List<Todo> get todos => _todos;

  void createTodo(Todo todo) {
    _todos.insert(0, todo);
    notifyListeners();
  }

  void updateTodo(int currentIndex, Todo todo) {
    _todos[currentIndex] = todo;
    notifyListeners();
  }

  void deleteTodo(int currentIndex) {
    _todos.removeAt(currentIndex);
    notifyListeners();
  }

  void deleteAllTodo() {
    _todos.clear();
    notifyListeners();
  }
}
