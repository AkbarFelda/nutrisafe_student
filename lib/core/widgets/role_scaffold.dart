import 'package:flutter/material.dart';
import 'package:nutrisafe_student/core/widgets/app_role.dart';

class RoleScaffold extends StatelessWidget {
  const RoleScaffold({
    super.key,
    required this.role,
    required this.child,
    this.bottomNavigationBar,
  });

  final AppRole role;
  final Widget child;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: isDark ? scheme.surface : role.background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    Color.alphaBlend(
                      role.primary.withValues(alpha: .16),
                      scheme.surface,
                    ),
                    scheme.surface,
                    scheme.surface,
                  ]
                : [role.surface, role.background, Colors.white],
            stops: const [0, .55, 1],
          ),
        ),
        child: SafeArea(child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
