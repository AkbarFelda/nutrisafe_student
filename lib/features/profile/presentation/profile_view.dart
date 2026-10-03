import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

part 'widgets/profile_components.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.role});

  final AppRole role;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isEditing = false;

  late final nameController = TextEditingController(
    text: widget.role == AppRole.student
        ? 'Icha Aulia Ambarwati'
        : 'SDN 1 Subang',
  );
  late final emailController = TextEditingController(
    text: widget.role == AppRole.student
        ? 'icha@student.id'
        : 'admin@sdn1subang.sch.id',
  );
  late final phoneController = TextEditingController(text: '0812 3456 7890');

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return RoleScaffold(
      role: role,
      bottomNavigationBar: RoleBottomNavigation(role: role, index: 2),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding,
          context.isShortPhone ? 14 : 26,
          context.pagePadding,
          28,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _isEditing ? 'Edit Profile' : 'Profile Saya',
                  style: TextStyle(
                    color: role.heading,
                    fontSize: context.adaptive(24),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: role.primary.withValues(alpha: .13),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  role == AppRole.student ? 'Siswa' : 'Sekolah',
                  style: TextStyle(
                    color: role.heading,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _ProfileHeader(role: role, name: nameController.text),
          const SizedBox(height: 18),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: _isEditing
                ? _EditProfileForm(
                    key: const ValueKey('edit'),
                    role: role,
                    nameController: nameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    onCancel: () => setState(() => _isEditing = false),
                    onSave: () {
                      setState(() => _isEditing = false);
                      Get.snackbar(
                        'Profile diperbarui',
                        'Perubahan berhasil disimpan secara lokal',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  )
                : _ProfileOverview(
                    key: const ValueKey('overview'),
                    role: role,
                    email: emailController.text,
                    phone: phoneController.text,
                    onEdit: () => setState(() => _isEditing = true),
                    onLogout: _confirmLogout,
                  ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    Get.dialog<void>(
      AlertDialog(
        icon: Icon(Icons.logout_rounded, color: widget.role.primary, size: 34),
        title: const Text('Keluar dari akun?'),
        content: const Text(
          'Kamu perlu masuk kembali untuk menggunakan NutriSafe.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 22),
        actions: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 240),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: Get.back,
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.login),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size(0, 44),
                      ),
                      child: const Text('Keluar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
