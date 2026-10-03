import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/controllers/app_controller.dart';
import 'package:nutrisafe_student/app/routes/app_pages.dart';
import 'package:nutrisafe_student/app/routes/app_routes.dart';
import 'package:nutrisafe_student/app/theme/app_theme.dart';

class NutriSafeApp extends GetView<AppController> {
  const NutriSafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'NutriSafe',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: controller.themeMode.value,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        unknownRoute: AppPages.unknownRoute,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          final phoneScale = (mediaQuery.size.shortestSide / 393).clamp(
            .82,
            1.0,
          );
          final requestedScale = mediaQuery.textScaler.scale(1);
          final effectiveScale = (requestedScale * phoneScale)
              .clamp(.82, 1.25)
              .toDouble();
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(effectiveScale),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
