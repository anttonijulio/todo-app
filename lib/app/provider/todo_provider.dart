import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {
  // todo temp
  final _todos = <Todo>[];
  List<Todo> get todos => _todos;

  final _doneTodos = <Todo>[];
  List<Todo> get doneTodos => _doneTodos;

  // add task
  void addTask(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  // tandai tugas sebagai selesai
  void markAsDone(String currentId) {
    // find task in the ongoing list
    int index = _todos.indexWhere((todo) => todo.id == currentId);

    if (index != -1) {
      // update task to "done" status and move to the _doneTodos
      final doneTodo = _todos[index].copyWith(isDone: true);
      _todos.removeAt(index);
      _doneTodos.add(doneTodo);
      notifyListeners();
    }
  }

  // batal menandai tugas selesai
  void markAsUndone(String currentId) {
    // find task in the done list
    int index = _doneTodos.indexWhere((todo) => todo.id == currentId);

    if (index != -1) {
      // update task to "not done" status and move back to the _todos list
      Todo undoneTodo = _doneTodos[index].copyWith(isDone: false);
      _doneTodos.removeAt(index);
      _todos.add(undoneTodo);
      notifyListeners();
    }
  }

  // update task
  void updateTask(Todo currentTodo) {
    int index = _todos.indexWhere((todo) => todo.id == currentTodo.id);

    if (index != -1) {
      _todos[index] = currentTodo;
      notifyListeners();
    }
  }

  // delete task
  void deleteTaskById(String currentId) {
    _todos.removeWhere((todo) => todo.id == currentId);
    _doneTodos.removeWhere((todo) => todo.id == currentId);
    notifyListeners();
  }

  void showDeleteDialog(BuildContext context, Todo currentTodo) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus tugas'),
          content: const Text('Kamu yakin ingin menghapus tugas ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                deleteTaskById(currentTodo.id);
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
