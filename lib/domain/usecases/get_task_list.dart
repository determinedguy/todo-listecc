import 'package:dartz/dartz.dart';
import 'package:todo_listecc/domain/repositories/task_repository.dart';
import 'package:todo_listecc/common/failure.dart';

class GetTaskList {
  final TaskRepository _repository;

  GetTaskList(this._repository);

  Future<Either<Failure, List<Task>>> execute() {
    return _repository.getTaskList();
  }
}
