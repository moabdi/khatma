import 'package:flutter/material.dart';

/// Gradient stat card with icon, value, and optional label
///
/// Displays a statistical value with an icon in a styled gradient card.
/// Perfect for dashboard or summary screens.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    this.label,
    this.expanded = true,
  });

  final IconData icon;
  final String value;
  final String? label;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cardContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.15),
                  theme.colorScheme.primary.withValues(alpha: 0.08),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 2),
            Text(
              label!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    return expanded ? Expanded(child: cardContent) : cardContent;
  }
}
