import 'package:todo_listecc/domain/repositories/todo_repository.dart';

class GetTodoStatus {
  final TodoRepository repository;

  GetTodoStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTodoList(id);
  }
}
