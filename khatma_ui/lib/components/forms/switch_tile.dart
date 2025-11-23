import 'package:flutter/material.dart';

/// Reusable switch list tile with icon
///
/// A SwitchListTile with consistent styling, icon, and subtitle.
/// Perfect for toggleable settings or features.
class KhatmaSwitchTile extends StatelessWidget {
  const KhatmaSwitchTile({
    super.key,
    required this.enabled,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    this.icon = Icons.toggle_on,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile(
      value: enabled,
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
      secondary: CircleAvatar(
        backgroundColor: enabled
            ? theme.primaryColor.withValues(alpha: 0.1)
            : theme.disabledColor.withValues(alpha: 0.1),
        child: Icon(
          icon,
          color: enabled ? theme.colorScheme.primary : theme.disabledColor,
          size: 24,
        ),
      ),
      onChanged: onChanged,
      activeTrackColor: theme.colorScheme.primary,
      inactiveThumbColor: theme.disabledColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
