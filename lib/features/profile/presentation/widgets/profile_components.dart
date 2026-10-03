part of '../profile_view.dart';

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.role, required this.name});

  final AppRole role;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [role.primary, role.heading],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: role.primary.withValues(alpha: .25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: context.adaptive(72),
            height: context.adaptive(72),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(
              role == AppRole.student
                  ? Icons.person_rounded
                  : Icons.school_rounded,
              color: Colors.white,
              size: context.adaptive(40),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role == AppRole.student
                      ? 'Siswa • Kelas 6A'
                      : 'Sekolah • Kabupaten Subang',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .82),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOverview extends StatelessWidget {
  const _ProfileOverview({
    super.key,
    required this.role,
    required this.email,
    required this.phone,
    required this.onEdit,
    required this.onLogout,
  });

  final AppRole role;
  final String email;
  final String phone;
  final VoidCallback onEdit;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SurfaceCard(
          child: Column(
            children: [
              _InfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: email,
              ),
              const Divider(height: 25),
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'Nomor HP',
                value: phone,
              ),
              const Divider(height: 25),
              _InfoRow(
                icon: Icons.badge_outlined,
                label: 'Status akun',
                value: 'Terverifikasi',
                valueColor: role.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SurfaceCard(
          child: Column(
            children: [
              _MenuTile(
                icon: Icons.edit_outlined,
                title: 'Edit profile',
                subtitle: 'Ubah informasi dasar akun',
                color: role.primary,
                onTap: onEdit,
              ),
              const Divider(height: 1),
              _MenuTile(
                icon: Icons.lock_outline_rounded,
                title: 'Keamanan akun',
                subtitle: 'Ubah password dan keamanan',
                color: role.primary,
                onTap: () => Get.snackbar('Keamanan', 'Fitur segera tersedia'),
              ),
              const Divider(height: 1),
              _MenuTile(
                icon: Icons.help_outline_rounded,
                title: 'Bantuan',
                subtitle: 'FAQ dan kontak bantuan',
                color: role.primary,
                onTap: () => Get.snackbar('Bantuan', 'Fitur segera tersedia'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Keluar dari Akun'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            foregroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm({
    super.key,
    required this.role,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.onCancel,
    required this.onSave,
  });

  final AppRole role;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel('Nama lengkap / Instansi'),
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: appInputDecoration(
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 14),
          const FormLabel('Email'),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: appInputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 14),
          const FormLabel('Nomor handphone'),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: appInputDecoration(
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: const FittedBox(child: Text('Batal')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: PrimaryRoleButton(
                  role: role,
                  label: 'Simpan Perubahan',
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.muted),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.muted, fontSize: 11),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
