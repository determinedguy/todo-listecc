import 'package:dartz/dartz.dart';
import 'package:todo_listecc/common/failure.dart';
import 'package:todo_listecc/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, String>> saveTodo(Todo todo);
  Future<Either<Failure, String>> removeTodo(Todo todo);
  Future<Either<Failure, List<Todo>>> getTodoList();
}
