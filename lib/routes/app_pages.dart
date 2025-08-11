import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controllers/auth_controllers.dart';
import '../routes/app_routes.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/signup_screen.dart';
import '../views/home/add_task_screen.dart';
import '../views/home/edit_task_screen.dart';
import '../views/home/home_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: AppRoutes.addTask, page: () => AddTaskScreen()),
    GetPage(name: AppRoutes.editTask, page: () => EditTaskScreen()),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    try {
      final AuthController _authController = Get.find<AuthController>();
      final isLoggedIn = _authController.user != null;

      if (route == AppRoutes.login || route == AppRoutes.signup) {
        return isLoggedIn ? const RouteSettings(name: AppRoutes.home) : null;
      } else {
        return isLoggedIn ? null : const RouteSettings(name: AppRoutes.login);
      }
    } catch (e) {
      // If AuthController not found, redirect to login
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
