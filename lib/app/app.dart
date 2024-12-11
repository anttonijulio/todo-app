import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/todo_page.dart';
import 'provider/todo_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'My TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: false),
        home: const TodoPage(),
      ),
    );
  }
}
