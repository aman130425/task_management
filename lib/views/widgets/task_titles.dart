import 'package:flutter/material.dart';
import '../../models/task_models.dart';
import '../../utils/constants.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskTile({
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) Text(task.description),
            const SizedBox(height: 4),
            Chip(
              label: Text(
                task.status,
                style: TextStyle(
                  color: task.status == AppConstants.completed
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              backgroundColor: task.status == AppConstants.completed
                  ? Colors.green
                  : Colors.orange,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
