import 'package:flutter/material.dart';
import 'package:my_todo/app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import 'done_view.dart';
import 'on_going_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MY TODO'),
          bottom: TabBar(
            tabs: [
              Consumer<TodoProvider>(builder: (context, todoProvider, child) {
                return Tab(text: 'Berjalan ${todoProvider.todos.length}');
              }),
              Consumer<TodoProvider>(builder: (context, todoProvider, child) {
                return Tab(text: 'Selesai ${todoProvider.doneTodos.length}');
              }),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            // berjalan
            OnGoingView(),

            // selesai
            DoneView(),
          ],
        ),
      ),
    );
  }
}
