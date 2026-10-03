import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/core/widgets/not_found_view.dart';
import 'package:nutrisafe_student/features/auth/presentation/login_view.dart';
import 'package:nutrisafe_student/features/auth/presentation/register_view.dart';
import 'package:nutrisafe_student/features/auth/presentation/splash_view.dart';
import 'package:nutrisafe_student/features/home/presentation/dashboard_views.dart';
import 'package:nutrisafe_student/features/notifications/presentation/notification_view.dart';
import 'package:nutrisafe_student/features/profile/presentation/profile_view.dart';
import 'package:nutrisafe_student/features/reporting/presentation/report_views.dart';
import 'package:nutrisafe_student/features/school/presentation/school_operation_views.dart';

abstract final class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage<void>(name: AppRoutes.splash, page: SplashView.new),
    GetPage<void>(
      name: AppRoutes.login,
      page: () => LoginView(registrationSuccess: Get.arguments == true),
    ),
    GetPage<void>(name: AppRoutes.register, page: RegisterView.new),
    GetPage<void>(
      name: AppRoutes.studentDashboard,
      page: StudentDashboardView.new,
    ),
    GetPage<void>(
      name: AppRoutes.studentNotifications,
      page: () => const NotificationView(role: AppRole.student),
    ),
    GetPage<void>(
      name: AppRoutes.studentReport,
      page: () => const ReportFormView(role: AppRole.student),
    ),
    GetPage<void>(
      name: AppRoutes.studentReportDetail,
      page: () => const ReportDetailView(role: AppRole.student),
    ),
    GetPage<void>(
      name: AppRoutes.studentProfile,
      page: () => const ProfileView(role: AppRole.student),
    ),
    GetPage<void>(
      name: AppRoutes.schoolDashboard,
      page: SchoolDashboardView.new,
    ),
    GetPage<void>(
      name: AppRoutes.schoolNotifications,
      page: () => const NotificationView(role: AppRole.school),
    ),
    GetPage<void>(
      name: AppRoutes.schoolReport,
      page: () => const ReportFormView(role: AppRole.school),
    ),
    GetPage<void>(
      name: AppRoutes.schoolReportDetail,
      page: () => const ReportDetailView(role: AppRole.school),
    ),
    GetPage<void>(name: AppRoutes.foodReceipt, page: FoodReceiptView.new),
    GetPage<void>(
      name: AppRoutes.foodReceived,
      page: () => const FoodReceiptView(completed: true),
    ),
    GetPage<void>(name: AppRoutes.allergy, page: AllergyView.new),
    GetPage<void>(
      name: AppRoutes.schoolProfile,
      page: () => const ProfileView(role: AppRole.school),
    ),
  ];

  static final unknownRoute = GetPage<void>(
    name: '/not-found',
    page: NotFoundView.new,
  );
}
