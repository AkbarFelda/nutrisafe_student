import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/presentation/login_view.dart';
import 'package:nutrisafe_student/features/auth/presentation/register_view.dart';
import 'package:nutrisafe_student/features/home/presentation/dashboard_views.dart';
import 'package:nutrisafe_student/features/notifications/presentation/notification_view.dart';
import 'package:nutrisafe_student/features/profile/presentation/profile_view.dart';
import 'package:nutrisafe_student/features/profile/presentation/account_security_view.dart';
import 'package:nutrisafe_student/features/profile/presentation/help_view.dart';
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
    (
      name: 'student account security',
      page: const AccountSecurityView(role: AppRole.student),
    ),
    (name: 'school help', page: const HelpView(role: AppRole.school)),
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

  testWidgets('password visibility can be toggled on login', (tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: LoginView()));

    final passwordField = find.byType(TextField).at(1);
    expect(tester.widget<TextField>(passwordField).obscureText, isTrue);

    await tester.tap(find.byTooltip('Tampilkan password'));
    await tester.pump();

    expect(tester.widget<TextField>(passwordField).obscureText, isFalse);
    expect(find.byTooltip('Sembunyikan password'), findsOneWidget);
  });

  testWidgets('account security is a full page', (tester) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    await tester.pumpWidget(
      const GetMaterialApp(home: AccountSecurityView(role: AppRole.student)),
    );

    expect(find.text('Ganti Password'), findsOneWidget);
    expect(find.text('Password saat ini'), findsOneWidget);
    expect(find.text('Password baru'), findsOneWidget);
    expect(find.text('Konfirmasi password baru'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('report date is filled and photo source can be selected', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    await tester.pumpWidget(
      const GetMaterialApp(home: ReportFormView(role: AppRole.student)),
    );

    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('15').first);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.textContaining('15 '), findsWidgets);

    await tester.ensureVisible(find.text('PNG, JPG, JPEG'));
    await tester.tap(find.text('PNG, JPG, JPEG'));
    await tester.pumpAndSettle();
    expect(find.text('Ambil dari Kamera'), findsOneWidget);
    expect(find.text('Pilih dari Galeri'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('school registration shows school identity fields', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: RegisterView()));

    await tester.tap(find.text('Umum / Siswa'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sekolah').last);
    await tester.pumpAndSettle();

    expect(find.text('Nama Sekolah'), findsOneWidget);
    expect(find.text('NPSN'), findsOneWidget);
    expect(find.text('Alamat Sekolah'), findsOneWidget);
    expect(find.text('Jenjang'), findsOneWidget);
    expect(find.text('Password'), findsNothing);
  });
}

class _PhoneScenario {
  const _PhoneScenario(this.name, this.size, {this.textScale = 1});

  final String name;
  final Size size;
  final double textScale;
}
