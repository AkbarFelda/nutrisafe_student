import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';

enum AppRole { student, school }

extension AppRoleStyle on AppRole {
  Color get background => this == AppRole.student
      ? AppColors.studentBackground
      : AppColors.schoolBackground;
  Color get primary => this == AppRole.student
      ? AppColors.studentPrimary
      : AppColors.schoolPrimary;
  Color get heading =>
      this == AppRole.student ? AppColors.studentDark : AppColors.schoolDark;
  Color get surface => this == AppRole.student
      ? AppColors.studentSurface
      : AppColors.schoolSurface;
}
