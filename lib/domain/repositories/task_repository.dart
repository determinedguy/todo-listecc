import 'package:dartz/dartz.dart';
import 'package:todo_listecc/common/failure.dart';

abstract class TaskRepository {
  Future<Either<Failure, String>> saveTask(Task task);
  Future<Either<Failure, String>> removeTask(Task task);
  Future<bool> isAddedToTaskList(int id);
  Future<Either<Failure, List<Task>>> getTaskList();
}
