import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/core/config/app_config.dart';
import 'package:nutrisafe_student/core/data/dummy_data.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';
import 'package:nutrisafe_student/features/auth/controllers/auth_controller.dart';
import 'package:nutrisafe_student/features/notifications/controllers/notification_controller.dart';
import 'package:nutrisafe_student/features/notifications/data/models/notification_model.dart';
import 'package:nutrisafe_student/features/notifications/data/notification_repository.dart';
import 'package:nutrisafe_student/features/notifications/presentation/widgets/notification_card.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key, required this.role});

  final AppRole role;

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late final NotificationController controller =
      Get.isRegistered<NotificationController>()
      ? Get.find<NotificationController>()
      : Get.put(NotificationController(NotificationRepository()));

  String get _token => Get.isRegistered<AuthController>()
      ? Get.find<AuthController>().session.value?.token ?? ''
      : '';

  @override
  void initState() {
    super.initState();
    if (!AppConfig.demoMode && _token.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.load(_token),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return RoleScaffold(
      role: role,
      bottomNavigationBar: RoleBottomNavigation(role: role, index: 0),
      child: RefreshIndicator(
        onRefresh: () => controller.load(_token),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: context.isShortPhone ? 20 : 36),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notifikasi',
                      style: TextStyle(
                        color: role.foreground(context),
                        fontSize: context.adaptive(24),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.unreadCount.value > 0
                        ? TextButton(
                            onPressed: () => controller.markAllRead(_token),
                            child: const Text('Baca semua'),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => _buildContent(role)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(AppRole role) {
    if (AppConfig.demoMode) {
      return Column(
        children: DummyData.notifications
            .map(
              (item) => _card(
                role,
                item.title,
                item.message,
                item.time,
                item.isRead,
                () => _openDetail(role),
              ),
            )
            .toList(),
      );
    }
    if (controller.isLoading.value && controller.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(48),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (controller.errorMessage.value != null && controller.items.isEmpty) {
      return _MessageState(
        icon: Icons.cloud_off_rounded,
        message: controller.errorMessage.value!,
        action: () => controller.load(_token),
      );
    }
    if (controller.items.isEmpty) {
      return const _MessageState(
        icon: Icons.notifications_none_rounded,
        message: 'Belum ada notifikasi.',
      );
    }
    return Column(
      children: controller.items
          .map(
            (item) => _card(
              role,
              item.title,
              item.message,
              _relativeTime(item),
              item.isRead,
              () async {
                await controller.markRead(_token, item.id);
                _openDetail(role);
              },
            ),
          )
          .toList(),
    );
  }

  Widget _card(
    AppRole role,
    String title,
    String message,
    String time,
    bool isRead,
    VoidCallback onTap,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: NotificationCard(
      role: role,
      title: title,
      message: message,
      time: time,
      isRead: isRead,
      onTap: onTap,
    ),
  );

  void _openDetail(AppRole role) => Get.toNamed(
    role == AppRole.student
        ? AppRoutes.studentReportDetail
        : AppRoutes.schoolReportDetail,
  );

  String _relativeTime(NotificationModel item) {
    final date = item.createdAt?.toLocal();
    if (date == null) return '';
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 1) return 'Baru saja';
    if (difference.inHours < 1) return '${difference.inMinutes} mnt';
    if (difference.inDays < 1) return '${difference.inHours} jam';
    return '${difference.inDays} hari';
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({required this.icon, required this.message, this.action});

  final IconData icon;
  final String message;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(36),
    child: Column(
      children: [
        Icon(icon, size: 44, color: Theme.of(context).colorScheme.outline),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        if (action != null) ...[
          const SizedBox(height: 12),
          OutlinedButton(onPressed: action, child: const Text('Coba lagi')),
        ],
      ],
    ),
  );
}
