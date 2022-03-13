import 'package:todo_listecc/data/datasources/db/database_helper.dart';
import 'package:todo_listecc/data/datasources/todo_local_data_source.dart';
import 'package:todo_listecc/data/repositories/todo_repository_impl.dart';
import 'package:todo_listecc/domain/repositories/todo_repository.dart';
import 'package:todo_listecc/domain/usecases/get_todo_list.dart';
import 'package:todo_listecc/domain/usecases/remove_todo.dart';
import 'package:todo_listecc/domain/usecases/save_todo.dart';
import 'package:todo_listecc/presentation/provider/add_todo_notifier.dart';
import 'package:todo_listecc/presentation/provider/todo_detail_notifier.dart';
import 'package:todo_listecc/presentation/provider/todo_list_notifier.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => AddTodoNotifier(
      saveTodo: locator(),
    ),
  );
  locator.registerFactory(
    () => TodoDetailNotifier(
      removeTodo: locator(),
    ),
  );
  locator.registerFactory(
    () => TodoListNotifier(
      getTodoList: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetTodoList(locator()));
  locator.registerLazySingleton(() => RemoveTodo(locator()));
  locator.registerLazySingleton(() => SaveTodo(locator()));

  // repository
  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(databaseHelper: locator()));

  // database helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
