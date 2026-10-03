import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/widgets/app_role.dart';

class FormLabel extends StatelessWidget {
  const FormLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
  );
}

InputDecoration appInputDecoration({
  String? hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: AppColors.field,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF777777), width: 1.4),
    ),
  );
}

class UploadPlaceholder extends StatelessWidget {
  const UploadPlaceholder({
    super.key,
    this.height = 108,
    this.readOnly = false,
  });

  final double height;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: readOnly ? Colors.transparent : AppColors.field,
        border: Border.all(color: const Color(0xFF888888)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!readOnly)
              const Icon(
                Icons.upload_rounded,
                color: AppColors.muted,
                size: 36,
              ),
            Text(
              readOnly ? 'Foto Makanan' : 'PNG, JPG, JPEG',
              style: const TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryRoleButton extends StatelessWidget {
  const PrimaryRoleButton({
    super.key,
    required this.role,
    required this.label,
    required this.onPressed,
  });

  final AppRole role;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: role.primary,
        foregroundColor: Colors.white,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
