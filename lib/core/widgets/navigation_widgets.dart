import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
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
      elevation: 8,
      shadowColor: Colors.black12,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.notifications_none_rounded),
          label: 'Notifikasi',
        ),
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle_outlined),
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
