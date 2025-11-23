import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_images.dart';

/// Avatar displaying khatma icon with themed background
///
/// Can be reused anywhere a khatma visual representation is needed
class KhatmaAvatar extends StatelessWidget {
  const KhatmaAvatar({
    super.key,
    required this.icon,
    required this.color,
    this.size = 48.0,
  });

  final String icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: getIcon(
          icon,
          color: color,
          size: size * 0.5,
        ),
      ),
    );
  }
}
