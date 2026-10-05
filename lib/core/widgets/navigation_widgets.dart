import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_role.dart';

class RoleBottomNavigation extends StatelessWidget {
  const RoleBottomNavigation({super.key, required this.role, this.index = 1});

  final AppRole role;
  final int index;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: context.compactHeight(70, minimum: 60),
      selectedIndex: index,
      backgroundColor: Colors.white,
      indicatorColor: role.primary.withValues(alpha: .18),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          color: selected ? role.heading : AppColors.ink,
          fontSize: 12,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
        );
      }),
      overlayColor: WidgetStatePropertyAll(role.primary.withValues(alpha: .08)),
      elevation: 8,
      shadowColor: Colors.black12,
      destinations: [
        NavigationDestination(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.ink,
          ),
          selectedIcon: Icon(Icons.notifications_rounded, color: role.heading),
          label: 'Notifikasi',
        ),
        NavigationDestination(
          icon: const Icon(Icons.home_outlined, color: AppColors.ink),
          selectedIcon: Icon(Icons.home_rounded, color: role.heading),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: const Icon(Icons.account_circle_outlined, color: AppColors.ink),
          selectedIcon: Icon(Icons.account_circle_rounded, color: role.heading),
          label: 'Profil',
        ),
      ],
      onDestinationSelected: (value) {
        if (value == index) return;
        final routes = role == AppRole.student
            ? [
                AppRoutes.studentNotifications,
                AppRoutes.studentDashboard,
                AppRoutes.studentProfile,
              ]
            : [
                AppRoutes.schoolNotifications,
                AppRoutes.schoolDashboard,
                AppRoutes.schoolProfile,
              ];
        Get.offNamed(routes[value]);
      },
    );
  }
}

class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.title, required this.role});

  final String title;
  final AppRole role;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: role.heading,
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: role.heading,
              fontSize: context.adaptive(18),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
