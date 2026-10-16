import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/controllers/auth_controller.dart';
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/auth/data/models/auth_models.dart';

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
              const NutriSafeLogo(
                compact: true,
                foregroundColor: AppColors.ink,
              ),
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
                  color: Theme.of(context).colorScheme.surfaceContainer,
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _schoolName = TextEditingController();
  final _npsn = TextEditingController();
  final _address = TextEditingController();
  String _accountType = 'general';
  String _grade = 'SD/MI';

  late final AuthController _authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(AuthRepository()));

  bool get _isSchool => _accountType == 'school';

  @override
  void dispose() {
    for (final controller in [
      _name,
      _email,
      _phone,
      _password,
      _schoolName,
      _npsn,
      _address,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    final commonIsValid =
        _name.text.trim().isNotEmpty &&
        GetUtils.isEmail(_email.text.trim()) &&
        _phone.text.trim().isNotEmpty;
    final roleIsValid = _isSchool
        ? _schoolName.text.trim().isNotEmpty &&
              _npsn.text.trim().isNotEmpty &&
              _address.text.trim().isNotEmpty
        : _password.text.length >= 8;
    if (!commonIsValid || !roleIsValid) {
      showAppDialog(
        title: 'Data belum lengkap',
        message: _isSchool
            ? 'Lengkapi identitas sekolah, NPSN, dan alamat.'
            : 'Lengkapi data dan gunakan password minimal 8 karakter.',
        icon: Icons.warning_amber_rounded,
      );
      return;
    }

    if (_isSchool) {
      await _authController.registerSchool(
        SchoolRegistration(
          name: _name.text.trim(),
          email: _email.text.trim(),
          phone: _phone.text.trim(),
          schoolName: _schoolName.text.trim(),
          npsn: _npsn.text.trim(),
          address: _address.text.trim(),
          grade: _grade,
        ),
      );
    } else {
      await _authController.registerGeneral(
        GeneralRegistration(
          name: _name.text.trim(),
          email: _email.text.trim(),
          phone: _phone.text.trim(),
          password: _password.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel('Jenis Akun'),
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: _accountType,
          decoration: appInputDecoration(),
          items: const [
            DropdownMenuItem(value: 'general', child: Text('Umum / Siswa')),
            DropdownMenuItem(value: 'school', child: Text('Sekolah')),
          ],
          onChanged: (value) =>
              setState(() => _accountType = value ?? 'general'),
        ),
        const SizedBox(height: 10),
        const FormLabel('Nama Lengkap'),
        TextField(
          controller: _name,
          textInputAction: TextInputAction.next,
          decoration: appInputDecoration(
            prefixIcon: const Icon(Icons.person_outline_rounded),
          ),
        ),
        const SizedBox(height: 10),
        const FormLabel('Email'),
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: appInputDecoration(
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 10),
        const FormLabel('No. Handphone'),
        TextField(
          controller: _phone,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          decoration: appInputDecoration(
            prefixIcon: const Icon(Icons.phone_outlined),
          ),
        ),
        if (!_isSchool) ...[
          const SizedBox(height: 10),
          const FormLabel('Password'),
          PasswordField(
            controller: _password,
            textInputAction: TextInputAction.done,
          ),
        ],
        if (_isSchool) ...[
          const SizedBox(height: 10),
          const FormLabel('Nama Sekolah'),
          TextField(
            controller: _schoolName,
            textInputAction: TextInputAction.next,
            decoration: appInputDecoration(
              prefixIcon: const Icon(Icons.school_outlined),
            ),
          ),
          const SizedBox(height: 10),
          const FormLabel('NPSN'),
          TextField(
            controller: _npsn,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: appInputDecoration(),
          ),
          const SizedBox(height: 10),
          const FormLabel('Alamat Sekolah'),
          TextField(
            controller: _address,
            minLines: 2,
            maxLines: 3,
            decoration: appInputDecoration(
              prefixIcon: const Icon(Icons.location_on_outlined),
            ),
          ),
          const SizedBox(height: 10),
          const FormLabel('Jenjang'),
          DropdownButtonFormField<String>(
            isExpanded: true,
            initialValue: _grade,
            decoration: appInputDecoration(),
            items: const [
              DropdownMenuItem(value: 'SD/MI', child: Text('SD/MI')),
              DropdownMenuItem(value: 'SMP/MTs', child: Text('SMP/MTs')),
              DropdownMenuItem(value: 'SMA/MA/SMK', child: Text('SMA/MA/SMK')),
            ],
            onChanged: (value) => setState(() => _grade = value ?? 'SD/MI'),
          ),
        ],
        const SizedBox(height: 22),
        Obx(
          () => FilledButton(
            onPressed: _authController.isLoading.value ? null : _register,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF078EFF),
            ),
            child: _authController.isLoading.value
                ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(_isSchool ? 'Daftarkan Sekolah' : 'Daftar'),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: Get.back,
            child: Text.rich(
              TextSpan(
                text: 'Sudah punya akun? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                children: const [
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
