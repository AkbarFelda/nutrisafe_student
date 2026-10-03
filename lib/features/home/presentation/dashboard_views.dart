import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/home/presentation/widgets/dashboard_components.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: AppRole.student,
      bottomNavigationBar: const RoleBottomNavigation(role: AppRole.student),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: context.compactHeight(32, minimum: 16)),
          const Center(child: NutriSafeLogo(compact: true)),
          const SizedBox(height: 22),
          const FoodHeroBanner(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.pagePadding,
              14,
              context.pagePadding,
              12,
            ),
            child: const Text(
              'Dashboard Umum / Siswa',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
            child: DashboardTile(
              color: AppRole.student.primary,
              icon: Icons.assignment_rounded,
              label: 'Pelaporan Makanan',
              onTap: () => Get.toNamed(AppRoutes.studentReport),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

class SchoolDashboardView extends StatelessWidget {
  const SchoolDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: AppRole.school,
      bottomNavigationBar: const RoleBottomNavigation(role: AppRole.school),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: context.compactHeight(32, minimum: 16)),
          const Center(child: NutriSafeLogo(compact: true)),
          const SizedBox(height: 22),
          const FoodHeroBanner(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.pagePadding,
              14,
              context.pagePadding,
              12,
            ),
            child: Text(
              'Dashboard Sekolah',
              style: TextStyle(
                color: AppRole.school.heading,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
            child: Row(
              children: [
                Expanded(
                  child: DashboardTile(
                    color: AppRole.school.primary,
                    icon: Icons.inventory_2_rounded,
                    label: 'Penerimaan\nMakanan',
                    onTap: () => Get.toNamed(AppRoutes.foodReceipt),
                  ),
                ),
                SizedBox(width: context.horizontalGutter),
                Expanded(
                  child: DashboardTile(
                    color: AppRole.school.primary,
                    icon: Icons.assignment_rounded,
                    label: 'Pelaporan Makanan Sekolah',
                    onTap: () => Get.toNamed(AppRoutes.schoolReport),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.pagePadding,
              0,
              context.pagePadding,
              18,
            ),
            child: DashboardTile(
              color: AppRole.school.primary,
              icon: Icons.monitor_heart_rounded,
              label: 'Input Data Alergi Siswa',
              onTap: () => Get.toNamed(AppRoutes.allergy),
            ),
          ),
        ],
      ),
    );
  }
}
