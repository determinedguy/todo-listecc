import 'package:todo_listecc/common/state_enum.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/domain/usecases/get_todo_list.dart';
import 'package:flutter/foundation.dart';

class TodoListNotifier extends ChangeNotifier {
  var _todoList = <Todo>[];
  List<Todo> get todoList => _todoList;

  var _todoListState = RequestState.Empty;
  RequestState get todoListState => _todoListState;

  String _message = '';
  String get message => _message;

  TodoListNotifier({required this.getTodoList});

  final GetTodoList getTodoList;

  Future<void> fetchTodoList() async {
    _todoListState = RequestState.Loading;
    notifyListeners();

    final result = await getTodoList.execute();
    result.fold(
      (failure) {
        _todoListState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (todoListData) {
        _todoListState = RequestState.Loaded;
        _todoList = todoListData;
        notifyListeners();
      },
    );
  }
}
