import 'package:todo_listecc/common/exception.dart';
import 'package:todo_listecc/data/datasources/db/database_helper.dart';
import 'package:todo_listecc/data/models/task_table.dart';

abstract class TaskLocalDataSource {
  Future<String> insertTask(TaskTable task);
  Future<String> removeTask(TaskTable task);
  Future<TaskTable?> getTaskById(int id);
  Future<List<TaskTable>> getTaskList();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final DatabaseHelper databaseHelper;

  TaskLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTask(TaskTable task) async {
    try {
      await databaseHelper.insertTask(task);
      return 'Added to database';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTask(TaskTable task) async {
    try {
      await databaseHelper.removeTask(task);
      return 'Removed from database';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TaskTable?> getTaskById(int id) async {
    final result = await databaseHelper.getTaskById(id);
    if (result != null) {
      return TaskTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TaskTable>> getTaskList() async {
    final result = await databaseHelper.getTaskList();
    return result.map((data) => TaskTable.fromMap(data)).toList();
  }
}
