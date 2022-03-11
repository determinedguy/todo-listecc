import 'package:todo_listecc/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  const TodoModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.details,
  });

  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String details;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        title: json["title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "details": details,
      };

  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      details: details,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        startDate,
        endDate,
        details,
      ];
}
