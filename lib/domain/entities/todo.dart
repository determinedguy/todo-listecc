import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
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

  @override
  List<Object?> get props => [
        id,
        title,
        startDate,
        endDate,
        details,
      ];
}