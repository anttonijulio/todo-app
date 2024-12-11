import 'package:flutter_test/flutter_test.dart';
import 'package:my_todo/app/model/todo.dart';
import 'package:my_todo/app/provider/todo_provider.dart';

void main() {
  late TodoProvider todoProvider;

  setUp(() {
    todoProvider = TodoProvider();
  });

  group('TodoProvider Tests', () {
    test('Should add a task to the ongoing list', () {
      const todo = Todo(id: '1', task: 'Test Task');
      todoProvider.addTask(todo);

      expect(todoProvider.todos.length, 1);
      expect(todoProvider.todos[0].id, '1');
      expect(todoProvider.todos[0].task, 'Test Task');
    });

    test('Should mark a task as done', () {
      const todo = Todo(id: '1', task: 'Test Task');
      todoProvider.addTask(todo);

      todoProvider.markAsDone('1');

      expect(todoProvider.todos.length, 0);
      expect(todoProvider.doneTodos.length, 1);
      expect(todoProvider.doneTodos[0].isDone, true);
    });

    test('Should mark a task as undone', () {
      const todo = Todo(id: '1', task: 'Test Task', isDone: true);
      todoProvider.addTask(todo);
      todoProvider.markAsDone('1');
      todoProvider.markAsUndone('1');

      expect(todoProvider.todos.length, 1);
      expect(todoProvider.doneTodos.length, 0);
      expect(todoProvider.todos[0].isDone, false);
    });

    test('Should update an ongoing task', () {
      const todo = Todo(id: '1', task: 'Old Task');
      todoProvider.addTask(todo);

      final updatedTodo = todo.copyWith(task: 'Updated Task');
      todoProvider.updateTask(updatedTodo);

      expect(todoProvider.todos.length, 1);
      expect(todoProvider.todos[0].task, 'Updated Task');
    });

    test('Should delete a task from the ongoing list', () {
      const todo = Todo(id: '1', task: 'Test Task');
      todoProvider.addTask(todo);

      todoProvider.deleteTaskById('1');

      expect(todoProvider.todos.length, 0);
      expect(todoProvider.doneTodos.length, 0);
    });

    test('Should delete a task from the done list', () {
      const todo = Todo(id: '1', task: 'Test Task');
      todoProvider.addTask(todo);
      todoProvider.markAsDone('1');

      todoProvider.deleteTaskById('1');

      expect(todoProvider.todos.length, 0);
      expect(todoProvider.doneTodos.length, 0);
    });
  });
}
