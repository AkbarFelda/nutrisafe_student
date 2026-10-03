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
    return Scaffold(
      backgroundColor: role.background,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [role.surface, role.background, Colors.white],
            stops: const [0, .55, 1],
          ),
        ),
        child: SafeArea(child: child),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
