import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.isShortPhone ? 14 : 24),
              const NutriSafeLogo(compact: true),
              SizedBox(height: context.isShortPhone ? 12 : 20),
              FoodHeroBanner(height: context.isShortPhone ? 145 : 180),
              SizedBox(height: context.isShortPhone ? 14 : 24),
              const Text(
                'Daftar Akun',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: context.isShortPhone ? 12 : 18),
              Container(
                margin: EdgeInsets.symmetric(horizontal: context.pagePadding),
                padding: EdgeInsets.all(context.cardPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const _RegisterForm(),
              ),
              SizedBox(height: context.isShortPhone ? 14 : 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel('👤  Nama Lengkap'),
        TextField(decoration: appInputDecoration()),
        const SizedBox(height: 10),
        const FormLabel('📧  Email'),
        TextField(decoration: appInputDecoration()),
        const SizedBox(height: 10),
        const FormLabel('🔒  Password'),
        TextField(obscureText: true, decoration: appInputDecoration()),
        const SizedBox(height: 10),
        const FormLabel('📱  No. Handphone'),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: appInputDecoration(),
        ),
        const SizedBox(height: 10),
        const FormLabel('🏢  Nama Instansi / Umum'),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: appInputDecoration(),
          items: const [
            DropdownMenuItem(value: 'student', child: Text('Umum / Siswa')),
            DropdownMenuItem(value: 'school', child: Text('Sekolah')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: () => Get.offNamed(AppRoutes.login, arguments: true),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF078EFF),
          ),
          child: const Text('Daftar'),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: Get.back,
            child: const Text.rich(
              TextSpan(
                text: 'Sudah punya akun? ',
                style: TextStyle(color: Colors.black54, fontSize: 12),
                children: [
                  TextSpan(
                    text: 'Masuk',
                    style: TextStyle(
                      color: Color(0xFF3A67DD),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
