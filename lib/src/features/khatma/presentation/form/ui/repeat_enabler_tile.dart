import 'package:flutter/material.dart';
import 'package:khatma/src/utils/common.dart';

class RepeatKhatmaTile extends StatelessWidget {
  const RepeatKhatmaTile({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile(
      value: enabled,
      title: Text(
        AppLocalizations.of(context).repeat,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        AppLocalizations.of(context).autoRepeatDescription,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
      secondary: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.autorenew,
          color: enabled ? theme.primaryColor : theme.disabledColor,
        ),
      ),
      onChanged: onChanged,
      activeColor: theme.primaryColor,
      inactiveThumbColor: theme.disabledColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
