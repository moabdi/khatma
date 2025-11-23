import 'package:flutter/material.dart';

/// Information banner with icon and text
///
/// Displays a styled container with an icon and message.
/// Can be reused for displaying tips, instructions, warnings, or information.
class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderColor,
  });

  final String message;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ??
            theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ??
              theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
