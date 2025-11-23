import 'package:flutter/material.dart';

/// Circular avatar with progress indicator ring
///
/// Shows a widget in the center with a circular progress ring around it.
/// The progress ring animates to the specified progress value.
class CircularAvatarWithProgress extends StatelessWidget {
  const CircularAvatarWithProgress({
    super.key,
    required this.child,
    required this.color,
    required this.progress,
    this.size = 60.0,
    this.strokeWidth = 4.0,
    this.backgroundColor,
  });

  final Widget child;
  final Color color;
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular progress indicator
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),

          // Center content container
          Container(
            width: size - (strokeWidth * 4),
            height: size - (strokeWidth * 4),
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
