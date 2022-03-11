import 'dart:async';

import 'package:todo_listecc/data/models/task_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblTask = 'task';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/todo_list_data.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTask (
        id INTEGER PRIMARY KEY,
        title TEXT,
        startDate TEXT,
        endDate TEXT,
        details TEXT
      );
    ''');
  }

  Future<int> insertTask(TaskTable task) async {
    final db = await database;
    return await db!.insert(_tblTask, task.toJson());
  }

  Future<int> removeTask(TaskTable task) async {
    final db = await database;
    return await db!.delete(
      _tblTask,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<Map<String, dynamic>?> getTaskById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTask,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTaskList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTask);

    return results;
  }
}
