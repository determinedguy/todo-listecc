import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';

class TodoTable extends Equatable {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String details;

  const TodoTable({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  factory TodoTable.fromEntity(Todo todo) => TodoTable(
        id: todo.id,
        title: todo.title,
        startDate: todo.startDate,
        endDate: todo.endDate,
        details: todo.details,
      );

  factory TodoTable.fromMap(Map<String, dynamic> map) => TodoTable(
        id: map['id'],
        title: map['title'],
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        details: map['details'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'details': details,
      };

  Todo toEntity() => Todo(
        id: id,
        title: title,
        startDate: startDate,
        endDate: endDate,
        details: details,
      );

  @override
  List<Object?> get props => [id, title, startDate, endDate, details];
}
