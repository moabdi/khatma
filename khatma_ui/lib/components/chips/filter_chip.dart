import 'package:flutter/material.dart';

/// Animated filter chip with selection state
///
/// A chip-style button with icon, label, optional count badge, and selection state.
/// Perfect for filtering lists or toggling options.
class KhatmaFilterChip extends StatelessWidget {
  const KhatmaFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    this.onTap,
    this.count,
    this.isEnabled = true,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final int? count;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool canTap = isEnabled && onTap != null;

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: InkWell(
        onTap: canTap ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                count != null ? '$label ($count)' : label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
