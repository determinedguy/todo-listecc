import 'package:dartz/dartz.dart';
import 'package:todo_listecc/common/failure.dart';
import 'package:todo_listecc/domain/repositories/task_repository.dart';

class RemoveTask {
  final TaskRepository repository;

  RemoveTask(this.repository);

  Future<Either<Failure, String>> execute(Task task) {
    return repository.removeTask(task);
  }
}
