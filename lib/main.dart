import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:todo_listecc/common/utils.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/presentation/pages/about_page.dart';
import 'package:todo_listecc/presentation/pages/add_todo_page.dart';
import 'package:todo_listecc/presentation/pages/home_page.dart';
import 'package:todo_listecc/injection.dart' as di;
import 'package:todo_listecc/presentation/pages/todo_detail_page.dart';
import 'package:todo_listecc/presentation/provider/add_todo_notifier.dart';
import 'package:todo_listecc/presentation/provider/todo_detail_notifier.dart';
import 'package:todo_listecc/presentation/provider/todo_list_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AddTodoNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TodoDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TodoListNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Listecc',
        theme: appTheme,
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case AddTodoPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AddTodoPage());
            case TodoDetailPage.ROUTE_NAME:
              final todo = settings.arguments as Todo;
              return MaterialPageRoute(
                builder: (_) => TodoDetailPage(todo),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}