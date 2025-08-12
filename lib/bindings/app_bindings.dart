import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../controllers/auth_controllers.dart';
import '../controllers/task_controllers.dart';
import '../services/firebase_service.dart';
import '../utils/connectivity_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services (Singleton - app start pe initialize)
    Get.put(FirebaseService(), permanent: true);
    Get.put(ConnectivityService(), permanent: true).init();

    // Controllers (Eager loading - app start pe initialize)
    Get.put(AuthController());
    Get.put(TaskController());
    // Get.lazyPut<TaskController>(() => TaskController());
  }
}
