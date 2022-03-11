import 'package:dartz/dartz.dart';
import 'package:todo_listecc/data/datasources/task_local_data_source.dart';
import 'package:todo_listecc/data/models/task_table.dart';
import 'package:todo_listecc/domain/repositories/task_repository.dart';
import 'package:todo_listecc/common/exception.dart';
import 'package:todo_listecc/common/failure.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> saveTask(Task task) async {
    try {
      final result =
          await localDataSource.insertTask(TaskTable.fromEntity(task));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeTask(Task task) async {
    try {
      final result =
          await localDataSource.removeTask(TaskTable.fromEntity(task));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToTaskList(int id) async {
    final result = await localDataSource.getTaskById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Task>>> getTaskList() async {
    final result = await localDataSource.getTaskList();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
