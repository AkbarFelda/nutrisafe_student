import 'dart:async';

import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/config/app_config.dart';
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/auth/data/models/auth_models.dart';
import 'package:nutrisafe_student/features/school/controllers/school_controller.dart';

class AuthController extends GetxController {
  AuthController(this._repository);

  final AuthRepository _repository;

  final isLoading = false.obs;
  final session = Rxn<AuthSession>();

  Future<void> login({required String email, required String password}) async {
    await _run(() async {
      final result = AppConfig.demoMode
          ? AuthSession(
              user: AuthUser(email: email, role: roleFromEmail(email)),
              token: 'demo-token',
            )
          : await _repository.login(email: email, password: password);
      session.value = result;
      final role = result.user.role.toLowerCase();
      final isSchool =
          role.contains('sekolah') ||
          role.contains('school') ||
          roleFromEmail(result.user.email) == 'sekolah';
      await Get.offAllNamed(
        isSchool ? AppRoutes.schoolDashboard : AppRoutes.studentDashboard,
      );
      if (!AppConfig.demoMode &&
          isSchool &&
          result.token?.isNotEmpty == true &&
          Get.isRegistered<SchoolController>()) {
        unawaited(Get.find<SchoolController>().loadAll(result.token!));
      }
    });
  }

  Future<void> registerGeneral(GeneralRegistration registration) async {
    await _run(() async {
      if (!AppConfig.demoMode) {
        await _repository.registerGeneral(registration);
      }
      await Get.offNamed(AppRoutes.login, arguments: true);
    });
  }

  Future<void> registerSchool(SchoolRegistration registration) async {
    await _run(() async {
      if (!AppConfig.demoMode) {
        await _repository.registerSchool(registration);
      }
      await Get.offNamed(AppRoutes.login, arguments: true);
    });
  }

  Future<void> logout() async {
    await _run(() async {
      if (!AppConfig.demoMode) {
        await _repository.logout(session.value?.token);
      }
      session.value = null;
      await Get.offAllNamed(AppRoutes.login);
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      await action();
    } on ApiException catch (error) {
      Get.snackbar('Permintaan gagal', error.message);
    } on FormatException {
      Get.snackbar(
        'Respons tidak valid',
        'Server mengirim format yang tidak dikenali.',
      );
    } catch (_) {
      Get.snackbar(
        'Tidak dapat terhubung',
        'Periksa koneksi internet lalu coba lagi.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
