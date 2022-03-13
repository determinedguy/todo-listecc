import 'package:todo_listecc/domain/repositories/todo_repository.dart';

class GetTodoAmount {
  final TodoRepository repository;

  GetTodoAmount(this.repository);

  Future<int> execute() async {
    return repository.getTodoAmount();
  }
}
