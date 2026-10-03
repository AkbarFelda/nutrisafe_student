import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';

class RegistrationSuccessBanner extends StatelessWidget {
  const RegistrationSuccessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.pagePadding * 1.5),
      padding: const EdgeInsets.symmetric(vertical: 9),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFAAC9D9),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Text(
        'Akun berhasil dibuat! Silakan masuk',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11),
      ),
    );
  }
}
