import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider.dart';

class DoneView extends StatelessWidget {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.doneTodos.isEmpty) {
            return _buildEmptyTask();
          } else {
            return _buildTodoList(todoProvider);
          }
        },
      ),
    );
  }

  Widget _buildEmptyTask() {
    return const Center(child: Text('Tidak ada tugas yang selesai'));
  }

  Widget _buildTodoList(TodoProvider todoProvider) {
    return ListView.builder(
      itemCount: todoProvider.doneTodos.length,
      itemBuilder: (context, index) {
        final todo = todoProvider.doneTodos[index];

        return ListTile(
          title: Text(todo.task),
          trailing: Checkbox(
            value: todo.isDone,
            // mark as un done
            onChanged: (isDone) {
              if (isDone == true) {
                todoProvider.markAsDone(todo.id);
              } else {
                todoProvider.markAsUndone(todo.id);
              }
            },
          ),
          // delete task
          onLongPress: () =>
              context.read<TodoProvider>().showDeleteDialog(context, todo),
        );
      },
    );
  }
}
