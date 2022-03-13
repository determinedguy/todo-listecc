import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/usecases/save_todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTodoNotifier extends ChangeNotifier {
  static const todoAddSuccessMessage = 'Added to Database';

  final SaveTodo saveTodo;

  AddTodoNotifier({
    required this.saveTodo,
  });

  String _todoMessage = '';
  String get todoMessage => _todoMessage;

  Future<void> addTodo(Todo todo) async {
    final result = await saveTodo.execute(todo);

    await result.fold(
      (failure) async {
        _todoMessage = failure.message;
      },
      (successMessage) async {
        _todoMessage = successMessage;
      },
    );
  }
}
