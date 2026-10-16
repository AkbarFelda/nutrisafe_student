import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nutrisafe_student/app/app.dart';
import 'package:nutrisafe_student/app/bindings/app_binding.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AppBinding().dependencies();
  });

  tearDown(Get.reset);

  testWidgets('shows the NutriSafe splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NutriSafeApp());

    expect(find.text('NutriSafe MBG'), findsOneWidget);
  });
}
