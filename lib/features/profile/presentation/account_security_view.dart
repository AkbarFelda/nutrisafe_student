import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

class AccountSecurityView extends StatefulWidget {
  const AccountSecurityView({super.key, required this.role});

  final AppRole role;

  @override
  State<AccountSecurityView> createState() => _AccountSecurityViewState();
}

class _AccountSecurityViewState extends State<AccountSecurityView> {
  final _newPasswordController = TextEditingController();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _save() {
    if (_newPasswordController.text.length < 8) {
      showAppDialog(
        title: 'Password belum aman',
        message: 'Gunakan minimal 8 karakter.',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }
    if (_newPasswordController.text != _confirmationController.text) {
      showAppDialog(
        title: 'Password tidak sama',
        message: 'Periksa kembali konfirmasi password.',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }
    showAppDialog(
      title: 'Berhasil',
      message: 'Password akun berhasil diperbarui.',
      icon: Icons.check_circle_outline_rounded,
      iconColor: widget.role.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return RoleScaffold(
      role: role,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          context.pagePadding,
          context.isShortPhone ? 10 : 20,
          context.pagePadding,
          28,
        ),
        children: [
          PageHeading(title: 'Keamanan Akun', role: role),
          const SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(context.cardPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, color: role.primary, size: 38),
                const SizedBox(height: 10),
                const Text(
                  'Ganti Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  'Gunakan password yang kuat dan tidak dipakai pada akun lain.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 22),
                const FormLabel('Password saat ini'),
                const PasswordField(textInputAction: TextInputAction.next),
                const SizedBox(height: 14),
                const FormLabel('Password baru'),
                PasswordField(
                  controller: _newPasswordController,
                  hint: 'Minimal 8 karakter',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),
                const FormLabel('Konfirmasi password baru'),
                PasswordField(
                  controller: _confirmationController,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                PrimaryRoleButton(
                  role: role,
                  label: 'Simpan Password',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
