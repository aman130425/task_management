import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';

class Task {
  String? id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? AppConstants.pending,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
