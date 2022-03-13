import 'package:dartz/dartz.dart';
import 'package:todo_listecc/data/datasources/todo_local_data_source.dart';
import 'package:todo_listecc/data/models/todo_table.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/repositories/todo_repository.dart';
import 'package:todo_listecc/common/exception.dart';
import 'package:todo_listecc/common/failure.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> saveTodo(Todo todo) async {
    try {
      final result =
          await localDataSource.insertTodo(TodoTable.fromEntity(todo));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeTodo(Todo todo) async {
    try {
      final result =
          await localDataSource.removeTodo(TodoTable.fromEntity(todo));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    final result = await localDataSource.getTodoList();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
