import 'package:todo_listecc/domain/repositories/todo_repository.dart';

class GetTodoListStatus {
  final TodoRepository repository;

  GetTodoListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTodoList(id);
  }
}
