import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

/// Circular avatar with progress indicator around it
///
/// Shows khatma icon in the center with circular progress ring
/// Can be reused anywhere a khatma needs visual representation with progress
class KhatmaCircularAvatar extends StatelessWidget {
  const KhatmaCircularAvatar({
    super.key,
    required this.icon,
    required this.color,
    required this.progress,
    this.size = 60.0,
    this.showPercentage = true,
  });

  final String icon;
  final Color color;
  final double progress;
  final double size;
  final bool showPercentage;

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
              strokeWidth: 4,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),

          // Icon container
          Container(
            width: size - 16,
            height: size - 16,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Center(
              child: getIcon(
                icon,
                color: color,
                size: (size - 16) * 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
