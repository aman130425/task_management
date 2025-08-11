import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controllers.dart';
import '../../models/task_models.dart';
import '../../utils/constants.dart';
import '../widgets/common_text_field.dart';
import '../../utils/connectivity_service.dart';

class EditTaskScreen extends StatefulWidget {
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskController _taskController = Get.find();
  late final Task _task;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _task = Get.arguments as Task;
    _titleController = TextEditingController(text: _task.title);
    _descriptionController = TextEditingController(text: _task.description);
    _status = _task.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.editTask)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommonTextField(
              controller: _titleController,
              labelText: AppConstants.title,
              prefixIcon: const Icon(Icons.title),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: _descriptionController,
              labelText: AppConstants.description,
              maxLines: 3,
              prefixIcon: const Icon(Icons.description),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              items: [
                DropdownMenuItem(
                  value: AppConstants.pending,
                  child: Text(AppConstants.pending),
                ),
                DropdownMenuItem(
                  value: AppConstants.completed,
                  child: Text(AppConstants.completed),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: AppConstants.status,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isEmpty) {
                  Get.snackbar(AppConstants.errorMessage, AppConstants.errorMessageText);
                  return;
                }

                final online = await Get.find<ConnectivityService>().ensureOnline();
                if (!online) return;

                final updatedTask = Task(
                  id: _task.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  status: _status,
                  createdAt: _task.createdAt,
                );

                await _taskController.updateTask(updatedTask);
                Get.back();
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
