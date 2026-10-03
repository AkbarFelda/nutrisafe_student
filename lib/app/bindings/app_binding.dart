import 'package:get/get.dart';
import 'package:nutrisafe_student/app/controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
  }
}
