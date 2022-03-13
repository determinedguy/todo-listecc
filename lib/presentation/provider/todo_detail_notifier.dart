import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/usecases/remove_todo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodoDetailNotifier extends ChangeNotifier {
  static const todoRemoveSuccessMessage = 'Removed from database';
  
  final RemoveTodo removeTodo;

  TodoDetailNotifier({
    required this.removeTodo,
  });
  
  String _todoMessage = '';
  String get todoMessage => _todoMessage;

  Future<void> removeFromList(Todo todo) async {
    final result = await removeTodo.execute(todo);

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
