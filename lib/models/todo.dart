import 'dart:convert';

class Todo {
  final String? task;

  const Todo({this.task});

  Todo copyWith({
    String? task,
  }) {
    return Todo(
      task: task ?? this.task,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      task: map['task'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() => 'Todo(task: $task)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo && other.task == task;
  }

  @override
  int get hashCode => task.hashCode;
}
