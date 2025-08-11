import 'package:flutter/material.dart';
import '../../models/task_models.dart';
import '../../utils/constants.dart';
import '../../utils/app_colors.dart';

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
            // if (task.description.isNotEmpty) Text(task.description),
            const SizedBox(height: 4),
            Chip(
              label: Text(
                task.status,
                style: TextStyle(
                  color: task.status == AppConstants.completed
                      ? AppColors.chipCompletedText
                      : AppColors.chipPendingText,
                ),
              ),
              backgroundColor: task.status == AppConstants.completed
                  ? AppColors.chipCompletedBg
                  : AppColors.chipPendingBg,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.iconEdit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.iconDelete),
              onPressed: () async {
                final bool? confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text(AppConstants.deleteTask),
                    content: const Text(AppConstants.deletePermissionText),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text(AppConstants.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text(AppConstants.delete),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  onDelete();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
