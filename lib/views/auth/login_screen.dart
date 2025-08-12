import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/utils/constants.dart';

import '../../controllers/auth_controllers.dart';
import '../../routes/app_routes.dart';
import '../widgets/common_text_field.dart';
import '../../utils/connectivity_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.login),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonTextField(
              controller: _emailController,
              labelText: AppConstants.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
              textInputAction: TextInputAction.next,
              // onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: _passwordController,
              labelText: AppConstants.password,
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),
            Obx(
              () => _authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          final online = await Get.find<ConnectivityService>()
                              .ensureOnline();
                          if (!online) return;
                          await _authController.signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          if (_authController.user != null) {
                            Get.offNamed('/home');
                          }
                        } catch (e) {
                          Get.snackbar(AppConstants.errorMessage, e.toString());
                        }
                      },
                      child: const Text(AppConstants.login),
                    ),
            ),
            TextButton(
              onPressed: () => Get.offNamed(AppRoutes.signup),
              child: const Text(AppConstants.dontHaveAnAccounttext),
            ),
          ],
        ),
      ),
    );
  }
}
