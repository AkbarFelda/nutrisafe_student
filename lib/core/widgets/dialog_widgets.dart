import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showAppDialog({
  required String title,
  required String message,
  IconData icon = Icons.info_outline_rounded,
  Color? iconColor,
}) {
  return Get.dialog<void>(
    AlertDialog(
      icon: Icon(icon, color: iconColor, size: 38),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(message, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [FilledButton(onPressed: Get.back, child: const Text('OK'))],
    ),
    barrierDismissible: false,
  );
}
