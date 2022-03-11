import 'package:flutter/material.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:todo_listecc/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Listecc',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}