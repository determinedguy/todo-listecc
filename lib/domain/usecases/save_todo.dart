import 'package:dartz/dartz.dart';
import 'package:todo_listecc/common/failure.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/repositories/todo_repository.dart';

class SaveTodo {
  final TodoRepository repository;

  SaveTodo(this.repository);

  Future<Either<Failure, String>> execute(Todo todo) {
    return repository.saveTodo(todo);
  }
}
