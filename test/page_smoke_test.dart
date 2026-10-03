import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/presentation/login_view.dart';
import 'package:nutrisafe_student/features/auth/presentation/register_view.dart';
import 'package:nutrisafe_student/features/home/presentation/dashboard_views.dart';
import 'package:nutrisafe_student/features/notifications/presentation/notification_view.dart';
import 'package:nutrisafe_student/features/profile/presentation/profile_view.dart';
import 'package:nutrisafe_student/features/reporting/presentation/report_views.dart';
import 'package:nutrisafe_student/features/school/presentation/school_operation_views.dart';

void main() {
  setUp(() => Get.testMode = true);
  tearDown(Get.reset);

  const scenarios = <_PhoneScenario>[
    _PhoneScenario('small phone', Size(320, 568)),
    _PhoneScenario('compact Android', Size(360, 640)),
    _PhoneScenario('iPhone 16', Size(393, 852)),
    _PhoneScenario('large phone', Size(430, 932)),
    _PhoneScenario('small phone landscape', Size(568, 320)),
    _PhoneScenario('iPhone landscape', Size(852, 393)),
    _PhoneScenario('small phone large text', Size(320, 568), textScale: 1.3),
    _PhoneScenario('iPhone large text', Size(393, 852), textScale: 1.5),
  ];

  final pages = <({String name, Widget page})>[
    (name: 'login', page: const LoginView()),
    (
      name: 'login registration success',
      page: const LoginView(registrationSuccess: true),
    ),
    (name: 'register', page: const RegisterView()),
    (name: 'student dashboard', page: const StudentDashboardView()),
    (name: 'school dashboard', page: const SchoolDashboardView()),
    (
      name: 'student notifications',
      page: const NotificationView(role: AppRole.student),
    ),
    (
      name: 'school notifications',
      page: const NotificationView(role: AppRole.school),
    ),
    (
      name: 'student report form',
      page: const ReportFormView(role: AppRole.student),
    ),
    (
      name: 'school report form',
      page: const ReportFormView(role: AppRole.school),
    ),
    (
      name: 'student report detail',
      page: const ReportDetailView(role: AppRole.student),
    ),
    (
      name: 'school report detail',
      page: const ReportDetailView(role: AppRole.school),
    ),
    (name: 'food receipt', page: const FoodReceiptView()),
    (
      name: 'food receipt completed',
      page: const FoodReceiptView(completed: true),
    ),
    (name: 'allergy form', page: const AllergyView()),
    (name: 'student profile', page: const ProfileView(role: AppRole.student)),
    (name: 'school profile', page: const ProfileView(role: AppRole.school)),
  ];

  for (final scenario in scenarios) {
    testWidgets('all pages fit ${scenario.name}', (tester) async {
      await tester.binding.setSurfaceSize(scenario.size);

      for (final entry in pages) {
        await tester.pumpWidget(
          GetMaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scenario.textScale)),
              child: child!,
            ),
            home: entry.page,
          ),
        );
        await tester.pump();

        expect(find.byType(Scaffold), findsWidgets, reason: entry.name);
        expect(
          tester.takeException(),
          isNull,
          reason: '${entry.name} overflowed in ${scenario.name}',
        );
      }

      await tester.binding.setSurfaceSize(null);
    });
  }

  for (final scenario in scenarios) {
    testWidgets('edit profile fits ${scenario.name}', (tester) async {
      await tester.binding.setSurfaceSize(scenario.size);
      await tester.pumpWidget(
        GetMaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(scenario.textScale)),
            child: child!,
          ),
          home: const ProfileView(role: AppRole.student),
        ),
      );

      await tester.ensureVisible(find.text('Edit profile'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit profile'));
      await tester.pumpAndSettle();

      expect(find.text('Simpan Perubahan'), findsOneWidget);
      expect(
        tester.takeException(),
        isNull,
        reason: 'edit profile overflowed in ${scenario.name}',
      );
      await tester.binding.setSurfaceSize(null);
    });
  }
}

class _PhoneScenario {
  const _PhoneScenario(this.name, this.size, {this.textScale = 1});

  final String name;
  final Size size;
  final double textScale;
}
