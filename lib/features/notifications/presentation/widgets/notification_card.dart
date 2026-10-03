import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';
import 'package:nutrisafe_student/core/widgets/app_shell_widgets.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.role,
    required this.isRead,
    required this.onTap,
  });

  final AppRole role;
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.pagePadding),
      child: Material(
        color: Colors.white.withValues(alpha: isRead ? .85 : 1),
        elevation: isRead ? 0 : 2,
        shadowColor: Colors.black12,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: role.primary.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: role.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Laporan Terkirim!',
                        style: TextStyle(
                          color: isRead ? Colors.black45 : Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Laporan makanan kepada SPPG Indonesia pada tanggal 1 Februari 2026 berhasil terkirim!',
                        style: TextStyle(color: Colors.black45, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '12:00',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
