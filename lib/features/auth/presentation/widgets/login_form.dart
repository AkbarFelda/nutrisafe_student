import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel('📧  Email'),
        TextField(decoration: appInputDecoration()),
        const SizedBox(height: 12),
        const FormLabel('🔒  Password'),
        TextField(obscureText: true, decoration: appInputDecoration()),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: () => Get.offAllNamed(AppRoutes.studentDashboard),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF078EFF),
          ),
          child: const FittedBox(child: Text('Masuk sebagai Siswa')),
        ),
        const SizedBox(height: 9),
        OutlinedButton(
          onPressed: () => Get.offAllNamed(AppRoutes.schoolDashboard),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(45),
            foregroundColor: AppColors.schoolDark,
            side: const BorderSide(color: AppColors.schoolPrimary),
          ),
          child: const FittedBox(
            child: Text(
              'Masuk sebagai Sekolah',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Belum punya akun? ',
                style: TextStyle(color: Colors.black54, fontSize: 12),
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
