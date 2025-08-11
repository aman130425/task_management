import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_models.dart';
import '../services/firebase_service.dart';
import 'auth_controllers.dart';

class TaskController extends GetxController {
  final FirebaseService _firebaseService = Get.find();
  final AuthController _authController = Get.find();
  final RxList<Task> tasks = <Task>[].obs;
  StreamSubscription? _tasksSubscription;

  @override
  void onInit() {
    super.onInit();
    _observeUserChanges();
  }

  void _observeUserChanges() {
    _authController.userStream.listen((user) {
      if (user != null) {
        _fetchTasks();
      } else {
        _clearTasks();
      }
    });
  }

  void _fetchTasks() {
    _tasksSubscription?.cancel();
    _tasksSubscription = _firebaseService.getTasksStream().listen((
      fetchedTasks,
    ) {
      tasks.assignAll(fetchedTasks);
    });
  }

  void _clearTasks() {
    _tasksSubscription?.cancel();
    tasks.clear();
  }

  // @override
  // void onClose() {
  //   _tasksSubscription?.cancel();
  //   super.onClose();
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _tasksSubscription?.cancel();
    super.dispose();
  }

  Future<void> addTask(Task task) async {
    await _firebaseService.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _firebaseService.updateTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    await _firebaseService.deleteTask(taskId);
  }
}
