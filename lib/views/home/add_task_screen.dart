import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/task_controllers.dart';
import '../../models/task_models.dart';
import '../../utils/constants.dart';
import '../widgets/common_text_field.dart';
import '../../utils/connectivity_service.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _status = AppConstants.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.addTask)),
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
                  Get.snackbar(
                    AppConstants.errorMessage,
                    AppConstants.errorMessageText,
                  );
                  return;
                }

                final online = await Get.find<ConnectivityService>()
                    .ensureOnline();
                if (!online) return;

                final task = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  status: _status,
                  createdAt: DateTime.now(),
                );

                await _taskController.addTask(task);
                Get.back();
              },
              child: const Text(AppConstants.addTask),
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
