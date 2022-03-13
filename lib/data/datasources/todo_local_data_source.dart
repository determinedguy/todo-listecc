import 'package:todo_listecc/common/exception.dart';
import 'package:todo_listecc/data/datasources/db/database_helper.dart';
import 'package:todo_listecc/data/models/todo_table.dart';

abstract class TodoLocalDataSource {
  Future<String> insertTodo(TodoTable todo);
  Future<String> removeTodo(TodoTable todo);
  Future<List<TodoTable>> getTodoList();
  Future<int> getTodoAmount();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final DatabaseHelper databaseHelper;

  TodoLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTodo(TodoTable todo) async {
    try {
      await databaseHelper.insertTodo(todo);
      return 'Added to database';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTodo(TodoTable todo) async {
    try {
      await databaseHelper.removeTodo(todo);
      return 'Removed from database';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TodoTable>> getTodoList() async {
    final result = await databaseHelper.getTodoList();
    return result.map((data) => TodoTable.fromMap(data)).toList();
  }

  @override
  Future<int> getTodoAmount() async {
    final result = await databaseHelper.getTodoAmount();
    return result;
  }
}
