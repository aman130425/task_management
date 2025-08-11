import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controllers.dart';
import '../../routes/app_routes.dart';
import '../widgets/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonTextField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 24),
            Obx(
              () => _authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          await _authController.signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          if (_authController.user != null) {
                            Get.offAllNamed('/home');
                          }
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      child: const Text('Login'),
                    ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.signup),
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
