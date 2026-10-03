import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/constants/app_assets.dart';
import 'package:nutrisafe_student/core/constants/app_colors.dart';
import 'package:nutrisafe_student/core/utils/responsive.dart';

class NutriSafeLogo extends StatelessWidget {
  const NutriSafeLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = context.adaptive(compact ? 30 : 48);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: iconSize,
          height: iconSize,
          child: Image.asset(
            AppAssets.logo,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            semanticLabel: 'Logo NutriSafe',
            errorBuilder: (_, _, _) => const DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x1A06128F),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.health_and_safety_rounded,
                color: AppColors.navy,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'NutriSafe MBG',
              maxLines: 1,
              style: TextStyle(
                color: compact ? Colors.black : AppColors.navy,
                fontSize: context.adaptive(compact ? 17 : 30),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FoodHeroBanner extends StatelessWidget {
  const FoodHeroBanner({
    super.key,
    this.height,
    this.asset = AppAssets.bannerLogin,
  });

  final double? height;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == null ? context.heroHeight : context.adaptive(height!),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
          semanticLabel: 'Ilustrasi program makanan bergizi',
          errorBuilder: (_, _, _) => const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFDDF4FF), Color(0xFF9DDBA1)],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
