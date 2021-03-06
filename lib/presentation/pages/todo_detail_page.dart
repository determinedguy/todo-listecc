// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/presentation/pages/home_page.dart';
import 'package:todo_listecc/presentation/provider/todo_detail_notifier.dart';

class TodoDetailPage extends StatefulWidget {
  final Todo todo;

  const TodoDetailPage(this.todo, {Key? key}) : super(key: key);

  static const ROUTE_NAME = '/details';

  @override
  _TodoDetailPageState createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Task Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.title,
                style: kTextTheme.bodyText1,
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(width: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _showDate(widget.todo.startDate),
                      style: kTextTheme.subtitle1,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              Row(
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _showTime(widget.todo.startDate, widget.todo.endDate),
                      style: kTextTheme.subtitle1,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              Text(
                'Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const Padding(padding: EdgeInsets.all(4.0)),
              Text(
                widget.todo.details,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    await Provider.of<TodoDetailNotifier>(context, listen: false)
                        .removeFromList(widget.todo);
              
                    final message =
                        Provider.of<TodoDetailNotifier>(context, listen: false)
                            .todoMessage;
              
                    if (message == TodoDetailNotifier.todoRemoveSuccessMessage) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(message),
                            );
                          });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.delete),
                      Text('Delete Task'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _showDate(DateTime rawDate) {
    DateTime dateTime = rawDate.toLocal();
    List MONTH = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    Map DAY = {
      1: 'Senin',
      2: 'Selasa',
      3: 'Rabu',
      4: 'Kamis',
      5: 'Jumat',
      6: 'Sabtu',
      7: 'Minggu'
    };

    // Example: 2021-11-13T09:50:25.151Z
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    String monthName = MONTH[month - 1];
    String dayName = DAY[dateTime.weekday];

    // Use string interpolation
    String result = '$dayName, $day $monthName $year';

    return result;
  }

  String _showTime(DateTime startDate, DateTime endDate) {
    DateTime startTime = startDate.toLocal();
    DateTime endTime = endDate.toLocal();

    String start = DateFormat('hh.mm a').format(startTime);
    String end = DateFormat('hh.mm a').format(endTime);

    // Use string interpolation
    String result = '$start - $end';

    return result;
  }
}
