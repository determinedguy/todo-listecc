import 'dart:async';

import 'package:todo_listecc/data/models/todo_table.dart';
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

  static const String _tblTodo = 'todo';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/todo_list_data.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTodo (
        id INTEGER PRIMARY KEY,
        title TEXT,
        startDate TEXT,
        endDate TEXT,
        details TEXT
      );
    ''');
  }

  Future<int> insertTodo(TodoTable todo) async {
    final db = await database;
    return await db!.insert(_tblTodo, todo.toJson());
  }

  Future<int> removeTodo(TodoTable todo) async {
    final db = await database;
    return await db!.delete(
      _tblTodo,
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<Map<String, dynamic>?> getTodoById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTodo,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTodoList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTodo);

    return results;
  }

  Future<int> getTodoAmount() async {
    final db = await database;
    final int? count = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM id'));
    return count!;
  }
}
