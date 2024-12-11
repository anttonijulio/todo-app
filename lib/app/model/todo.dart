import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final bool isDone;

  const Todo({
    required this.id,
    required this.task,
    this.isDone = false,
  });

  Todo copyWith({
    String? id,
    String? task,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, task, isDone];
}
