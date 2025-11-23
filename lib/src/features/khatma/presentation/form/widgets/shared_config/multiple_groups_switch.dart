import 'package:flutter/material.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';

/// Toggle switch for allowing multiple group participation
///
/// Can be reused in any screen that needs to configure group participation settings
class MultipleGroupsSwitch extends StatelessWidget {
  const MultipleGroupsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.primaryContainer,
          child: Icon(Icons.groups, color: context.colorScheme.primary),
        ),
        title: Text(context.loc.allowMultipleGroups),
        subtitle: Text(context.loc.allowMultipleGroupsDesc),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
        onTap: () => onChanged(!value),
      ),
    );
  }
}
