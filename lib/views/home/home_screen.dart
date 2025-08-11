import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controllers.dart';
import '../../controllers/task_controllers.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../widgets/task_titles.dart';

class HomeScreen extends StatelessWidget {
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().signOut(),
          ),
        ],
      ),
      body: Obx(() {
        if (_taskController.tasks.isEmpty) {
          return const Center(
            child: Text('No tasks yet. Add your first task!'),
          );
        }
        return ListView.builder(
          itemCount: _taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = _taskController.tasks[index];
            return TaskTile(
              task: task,
              onEdit: () => Get.toNamed(AppRoutes.editTask, arguments: task),
              onDelete: () => _taskController.deleteTask(task.id!),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addTask),
        child: const Icon(Icons.add),
      ),
    );
  }
}
