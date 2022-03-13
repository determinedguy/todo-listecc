// Source: https://medium.flutterdevs.com/date-and-time-picker-in-flutter-72141e7531c

// ignore_for_file: constant_identifier_names

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:todo_listecc/presentation/pages/home_page.dart';
import 'package:todo_listecc/presentation/provider/add_todo_notifier.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/add';

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  double _height = 0;
  double _width = 0;

  String? _setTime = '', _setDate = '';

  String titleInput = '', detailsInput = '';
  String _startHour = '', _startMinute = '', _startTime = '';
  String _endHour = '', _endMinute = '', _endTime = '';

  String dateTime = '';

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    initializeDateFormatting();

    _dateController.text = DateFormat.yMd('id').format(DateTime.now());

    _startTimeController.text = formatDate(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    _endTimeController.text = formatDate(
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd('id').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.title),
                  hintText: 'Task Title',
                  labelText: 'Title',
                ),
                onChanged: (String? value) {
                  setState(() {
                    titleInput = value!;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    titleInput = value!;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the task title.';
                  }
                  return null;
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Date',
                  style: kTextTheme.subtitle2,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 1.4,
                    height: _height / 10,
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String? val) {
                        _setDate = val;
                      },
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Start Time',
                  style: kTextTheme.subtitle2,
                ),
                InkWell(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: Container(
                    width: _width / 1.4,
                    height: _height / 10,
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _startTimeController,
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'End Time',
                  style: kTextTheme.subtitle2,
                ),
                InkWell(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child: Container(
                    width: _width / 1.4,
                    height: _height / 10,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _endTimeController,
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.sticky_note_2),
                  hintText: 'Task Details',
                  labelText: 'Details',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (String? value) {
                  setState(() {
                    detailsInput = value!;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    detailsInput = value!;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the task details.';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Todo todo = Todo(
                  title: titleInput,
                  startDate: joinDateTime(selectedDate, selectedStartTime),
                  endDate: joinDateTime(selectedDate, selectedEndTime),
                  details: detailsInput,
                );

                await Provider.of<AddTodoNotifier>(context, listen: false)
                    .addTodo(todo);

                final message =
                    Provider.of<AddTodoNotifier>(context, listen: false)
                        .todoMessage;

                if (message == AddTodoNotifier.todoAddSuccessMessage) {
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
                  Icon(Icons.add),
                  Text('Add Task'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd('id').format(selectedDate);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null) {
      setState(() {
        selectedStartTime = picked;
        _startHour = selectedStartTime.hour.toString();
        _startMinute = selectedStartTime.minute.toString();
        _startTime = _startHour + ' : ' + _startMinute;
        _startTimeController.text = _startTime;
        _startTimeController.text = formatDate(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
                selectedStartTime.hour, selectedStartTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null) {
      setState(() {
        selectedEndTime = picked;
        _endHour = selectedEndTime.hour.toString();
        _endMinute = selectedEndTime.minute.toString();
        _endTime = _endHour + ' : ' + _endMinute;
        _endTimeController.text = _endTime;
        _endTimeController.text = formatDate(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
                selectedEndTime.hour, selectedEndTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  DateTime joinDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
