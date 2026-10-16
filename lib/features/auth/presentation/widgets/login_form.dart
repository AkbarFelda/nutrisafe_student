import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/controllers/auth_controller.dart';
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthController _authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(AuthRepository()));

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (!GetUtils.isEmail(email) || password.isEmpty) {
      showAppDialog(
        title: 'Data belum lengkap',
        message: 'Masukkan email dan password yang valid.',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }
    _authController.login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel('📧  Email'),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: appInputDecoration(
            hint: 'contoh@email.com',
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 12),
        const FormLabel('🔒  Password'),
        PasswordField(
          controller: _passwordController,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 22),
        Obx(
          () => FilledButton(
            onPressed: _authController.isLoading.value ? null : _login,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF078EFF),
            ),
            child: _authController.isLoading.value
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const FittedBox(child: Text('Masuk')),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Belum punya akun? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.register),
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    color: Color(0xFF3A67DD),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
