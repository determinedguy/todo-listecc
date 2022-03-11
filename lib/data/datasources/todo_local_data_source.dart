import 'package:todo_listecc/common/exception.dart';
import 'package:todo_listecc/data/datasources/db/database_helper.dart';
import 'package:todo_listecc/data/models/todo_table.dart';

abstract class TodoLocalDataSource {
  Future<String> insertTodo(TodoTable todo);
  Future<String> removeTodo(TodoTable todo);
  Future<TodoTable?> getTodoById(int id);
  Future<List<TodoTable>> getTodoList();
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
  Future<TodoTable?> getTodoById(int id) async {
    final result = await databaseHelper.getTodoById(id);
    if (result != null) {
      return TodoTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TodoTable>> getTodoList() async {
    final result = await databaseHelper.getTodoList();
    return result.map((data) => TodoTable.fromMap(data)).toList();
  }
}
