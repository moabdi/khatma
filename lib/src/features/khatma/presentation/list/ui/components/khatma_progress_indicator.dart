import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

/// Progress indicator with percentage text
///
/// Can be reused anywhere progress needs to be displayed
class KhatmaProgressIndicator extends StatelessWidget {
  const KhatmaProgressIndicator({
    super.key,
    required this.progress,
    required this.color,
    this.showPercentage = true,
    this.height = 8.0,
  });

  final double progress;
  final Color color;
  final bool showPercentage;
  final double height;

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$percentage%',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (progress >= 1.0)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: color,
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: color.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
