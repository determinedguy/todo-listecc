import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';

class TodoTable extends Equatable {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String details;

  const TodoTable({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  factory TodoTable.fromEntity(Todo todo) => TodoTable(
        title: todo.title,
        startDate: todo.startDate,
        endDate: todo.endDate,
        details: todo.details,
      );

  factory TodoTable.fromMap(Map<String, dynamic> map) => TodoTable(
        title: map['title'],
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        details: map['details'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'details': details,
      };

  Todo toEntity() => Todo(
        title: title,
        startDate: startDate,
        endDate: endDate,
        details: details,
      );

  @override
  List<Object?> get props => [title, startDate, endDate, details];
}
