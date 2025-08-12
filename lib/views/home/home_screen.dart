import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controllers.dart';
import '../../controllers/task_controllers.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/app_colors.dart';
import '../widgets/task_titles.dart';

class HomeScreen extends StatelessWidget {
  final TaskController _taskController = Get.find();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final email = _authController.user?.email ?? '';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppConstants.myTask),
              if (email.isNotEmpty)
                Text(email, style: Theme.of(context).textTheme.bodySmall),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.appBarIcon),
            onPressed: () {
              Get.defaultDialog(
                title: AppConstants.logout,
                middleText: AppConstants.logoutPermissionText,
                textCancel: AppConstants.cancel,
                textConfirm: AppConstants.logout,
                confirmTextColor: AppColors.textOnPrimary,
                onConfirm: () async {
                  await _authController.signOut();
                  // Get.offAllNamed('/login');
                  Get.toNamed(AppRoutes.login);
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_taskController.tasks.isEmpty) {
          return const Center(child: Text(AppConstants.noDataMessageText));
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
