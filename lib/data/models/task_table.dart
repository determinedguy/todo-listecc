import 'package:todo_listecc/domain/entities/task.dart';
import 'package:equatable/equatable.dart';

class TaskTable extends Equatable {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String details;

  const TaskTable({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  factory TaskTable.fromEntity(Task task) => TaskTable(
        id: task.id,
        title: task.title,
        startDate: task.startDate,
        endDate: task.endDate,
        details: task.details,
      );

  factory TaskTable.fromMap(Map<String, dynamic> map) => TaskTable(
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

  Task toEntity() => Task(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      details: details,
    );

  @override
  List<Object?> get props => [id, title, startDate, endDate, details];
}
