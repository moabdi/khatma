import 'package:flutter/material.dart';
import 'package:khatma_ui/components/avatar.dart';
import 'package:khatma_ui/components/radio_icon.dart';

/// Selectable option tile with icon and radio indicator
///
/// A ListTile for selecting between options with visual feedback.
/// Shows an icon, title, subtitle, and selection state.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      selected: isSelected,
      leading: Avatar(
        radius: 30,
        backgroundColor: isSelected
            ? theme.colorScheme.primary.withAlpha(30)
            : theme.disabledColor,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        bottom: isSelected
            ? Avatar(
                radius: 10,
                child: RadioIcon(selected: isSelected, size: 18),
              )
            : null,
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 25,
        ),
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textTheme.bodySmall,
            )
          : null,
      onTap: onTap,
    );
  }
}
