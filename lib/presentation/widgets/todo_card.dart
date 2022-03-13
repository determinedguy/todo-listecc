// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/presentation/pages/todo_detail_page.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard(this.todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                TodoDetailPage.ROUTE_NAME,
                arguments: todo,
              );
            },
            title: Text(todo.title),
            subtitle: Text(
              _showDate(todo.startDate) + _showTime(todo.startDate, todo.endDate)
            ),
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
