import 'package:flutter/material.dart';

/// Square avatar with rounded corners and themed background
///
/// Displays a widget (typically an icon) in a themed container.
/// Perfect for list items or cards that need consistent visual branding.
class ThemedAvatar extends StatelessWidget {
  const ThemedAvatar({
    super.key,
    required this.child,
    required this.color,
    this.size = 48.0,
    this.borderRadius = 12.0,
  });

  final Widget child;
  final Color color;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Center(child: child),
    );
  }
}
