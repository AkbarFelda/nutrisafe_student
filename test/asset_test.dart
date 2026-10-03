import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutrisafe_student/core/constants/app_assets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final asset in [
    AppAssets.logo,
    AppAssets.bannerLogin,
    AppAssets.bannerPartner,
  ]) {
    test('$asset exists and is a decodable image', () async {
      final data = await rootBundle.load(asset);
      expect(data.lengthInBytes, greaterThan(0));

      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();

      expect(frame.image.width, greaterThan(0));
      expect(frame.image.height, greaterThan(0));
      codec.dispose();
    });
  }
}
