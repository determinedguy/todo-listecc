// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listecc/common/state_enum.dart';
import 'package:todo_listecc/common/utils.dart';
import 'package:todo_listecc/presentation/pages/about_page.dart';
import 'package:todo_listecc/presentation/pages/add_todo_page.dart';
import 'package:todo_listecc/presentation/provider/todo_list_notifier.dart';
import 'package:todo_listecc/presentation/widgets/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TodoListNotifier>(context, listen: false)
            .fetchTodoList());
  }

  @override
  void didPopNext() {
    Provider.of<TodoListNotifier>(context, listen: false)
            .fetchTodoList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Todo Listecc'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'About Me',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AboutPage.ROUTE_NAME,
                );
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TodoListNotifier>(
          builder: (context, data, child) {
            if (data.todoListState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.todoListState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final todo = data.todoList[index];
                  return TodoCard(todo);
                },
                itemCount: data.todoList.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddTodoPage.ROUTE_NAME,
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
