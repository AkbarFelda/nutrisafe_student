import 'package:get/get.dart';
import 'package:nutrisafe_student/app/controllers/app_controller.dart';
import 'package:nutrisafe_student/features/auth/controllers/auth_controller.dart';
import 'package:nutrisafe_student/features/auth/data/auth_repository.dart';
import 'package:nutrisafe_student/features/school/controllers/school_controller.dart';
import 'package:nutrisafe_student/features/school/data/school_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    Get.lazyPut<AuthRepository>(AuthRepository.new, fenix: true);
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<SchoolRepository>(SchoolRepository.new, fenix: true);
    Get.lazyPut<SchoolController>(
      () => SchoolController(Get.find<SchoolRepository>()),
      fenix: true,
    );
  }
}
