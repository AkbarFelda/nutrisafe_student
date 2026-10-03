import 'package:flutter/widgets.dart';
import 'package:nutrisafe_student/app/app.dart';
import 'package:nutrisafe_student/app/bindings/app_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBinding().dependencies();
  runApp(const NutriSafeApp());
}
