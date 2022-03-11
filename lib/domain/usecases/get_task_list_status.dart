import 'package:todo_listecc/domain/repositories/task_repository.dart';

class GetTaskListStatus {
  final TaskRepository repository;

  GetTaskListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTaskList(id);
  }
}
