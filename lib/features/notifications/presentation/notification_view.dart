import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/data/dummy_data.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/notifications/presentation/widgets/notification_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key, required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      role: role,
      bottomNavigationBar: RoleBottomNavigation(role: role, index: 0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: context.isShortPhone ? 20 : 36),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
            child: Text(
              'Notifikasi',
              style: TextStyle(
                color: role.heading,
                fontSize: context.adaptive(24),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...DummyData.notifications.expand(
            (notification) => [
              NotificationCard(
                role: role,
                title: notification.title,
                message: notification.message,
                time: notification.time,
                isRead: notification.isRead,
                onTap: () => Get.toNamed(
                  role == AppRole.student
                      ? AppRoutes.studentReportDetail
                      : AppRoutes.schoolReportDetail,
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
