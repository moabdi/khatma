import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';
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
      secondary: CircleAvatar(
        backgroundColor: enabled
            ? theme.primaryColor.withOpacity(0.1)
            : theme.disabledColor.withOpacity(0.1),
        child: Icon(
          Icons.autorenew,
          color: enabled ? context.colorScheme.primary : theme.disabledColor,
          size: 24,
        ),
      ),
      onChanged: onChanged,
      activeThumbColor: context.colorScheme.primary,
      inactiveThumbColor: theme.disabledColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
