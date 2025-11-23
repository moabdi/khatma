import 'package:flutter/material.dart';

/// Simple badge widget with icon and label
///
/// Displays a compact badge with an icon and text.
/// Can be used for tags, categories, or status indicators.
class KhatmaBadge extends StatelessWidget {
  const KhatmaBadge({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: iconColor ?? theme.colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: textColor ?? theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
