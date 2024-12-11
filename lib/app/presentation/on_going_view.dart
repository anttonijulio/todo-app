import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/helper.dart';
import '../model/todo.dart';
import '../provider/todo_provider.dart';

class OnGoingView extends StatefulWidget {
  const OnGoingView({super.key});

  @override
  State<OnGoingView> createState() => _OnGoingViewState();
}

class _OnGoingViewState extends State<OnGoingView> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo list state
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.todos.isEmpty) {
            return _buildEmptyTask();
          } else {
            return _buildTodoList(todoProvider);
          }
        },
      ),

      // add task
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyTask() {
    return const Center(child: Text('Tidak ada tugas yang ditambahkan'));
  }

  Widget _buildTodoList(TodoProvider todoProvider) {
    return ListView.builder(
      itemCount: todoProvider.todos.length,
      itemBuilder: (context, index) {
        final todo = todoProvider.todos[index];

        return ListTile(
          title: Text(todo.task),
          // mark as done
          trailing: Checkbox(
            value: todo.isDone,
            onChanged: (isDone) {
              if (isDone == true) {
                todoProvider.markAsDone(todo.id);
              } else {
                todoProvider.markAsUndone(todo.id);
              }
            },
          ),
          // edit task
          onTap: () {
            _taskController.text = todo.task;
            _showTodoForm(context, todo);
          },
          // delete task
          onLongPress: () =>
              context.read<TodoProvider>().showDeleteDialog(context, todo),
        );
      },
    );
  }

  void _showTodoForm(BuildContext context, [Todo? todo]) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) => TodoForm(
        taskController: _taskController,
        onSave: (updatedTask) {
          if (todo != null) {
            // update todo
            context
                .read<TodoProvider>()
                .updateTask(todo.copyWith(task: updatedTask));
          } else {
            // add todo
            final id = Helper.generateId();
            context
                .read<TodoProvider>()
                .addTask(Todo(id: id, task: updatedTask));
          }
          Navigator.of(context).pop(); // close form
          _taskController.clear();
        },
      ),
    );
  }
}

class TodoForm extends StatelessWidget {
  const TodoForm({
    super.key,
    required this.taskController,
    required this.onSave,
  });

  final TextEditingController taskController;
  final ValueChanged<String> onSave;

  @override
  Widget build(BuildContext context) {
    const padding = 16.0;
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom + padding;

    return Container(
      padding: EdgeInsets.only(
        top: padding,
        left: padding,
        right: padding,
        bottom: bottomInsets,
      ),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Tulis tugas kamu',
        ),
        controller: taskController,
        autofocus: true,
        onSubmitted: (value) {
          onSave(taskController.text);
        },
      ),
    );
  }
}
