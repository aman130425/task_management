import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/bindings/app_bindings.dart';
import 'package:task_management_app/routes/app_pages.dart';
import 'package:task_management_app/routes/app_routes.dart';
import 'package:task_management_app/services/firebase_service.dart';
import 'package:task_management_app/utils/theme.dart';
import 'package:task_management_app/views/auth/login_screen.dart';
import 'package:task_management_app/views/home/home_screen.dart';

import 'controllers/auth_controllers.dart';
import 'controllers/task_controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: appTheme,
      initialBinding: AppBindings(),
      home: Root(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Obx(() {
      if (authController.user != null) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    });
  }
}
