import 'package:equatable/equatable.dart';

class OrderDocHistory extends Equatable {
  final String date;
  final String point;
  final bool done;
  final String authorName;
  final String executorName;
  final String comment;

  const OrderDocHistory({
    required this.point,
    required this.done,
    required this.authorName,
    required this.executorName,
    required this.comment,
    this.date = '',
  });

  factory OrderDocHistory.fromJson(Map<String, dynamic> json) {
    return OrderDocHistory(
      point: json['point'] ?? '',
      done: json['done'] ?? false,
      authorName: json['authorName'] ?? '',
      executorName: json['executorName'] ?? '',
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    point,
    done,
    authorName,
    executorName,
    comment,
    date,
  ];
}
