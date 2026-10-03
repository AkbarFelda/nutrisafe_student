import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/presentation/widgets/login_form.dart';
import 'package:nutrisafe_student/features/auth/presentation/widgets/registration_success_banner.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, this.registrationSuccess = false});

  final bool registrationSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.isShortPhone ? 16 : 28),
              const NutriSafeLogo(compact: true),
              SizedBox(height: context.isShortPhone ? 14 : 24),
              const FoodHeroBanner(),
              SizedBox(height: context.isShortPhone ? 18 : 30),
              if (registrationSuccess) const RegistrationSuccessBanner(),
              if (registrationSuccess) const SizedBox(height: 14),
              const Text(
                'Masuk Akun',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: context.isShortPhone ? 16 : 26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    context.cardPadding,
                    context.isShortPhone ? 20 : 30,
                    context.cardPadding,
                    context.isShortPhone ? 20 : 27,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const LoginForm(),
                ),
              ),
              SizedBox(height: context.isShortPhone ? 18 : 30),
            ],
          ),
        ),
      ),
    );
  }
}
