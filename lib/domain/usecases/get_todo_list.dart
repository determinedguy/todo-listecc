import 'package:dartz/dartz.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/repositories/todo_repository.dart';
import 'package:todo_listecc/common/failure.dart';

class GetTodoList {
  final TodoRepository _repository;

  GetTodoList(this._repository);

  Future<Either<Failure, List<Todo>>> execute() {
    return _repository.getTodoList();
  }
}
