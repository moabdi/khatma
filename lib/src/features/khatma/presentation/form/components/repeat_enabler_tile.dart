import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';

class RepeatKhatmaTile extends StatelessWidget {
  const RepeatKhatmaTile(
      {super.key, this.enabled = true, required this.onChanged});

  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: enabled,
      title: Text(AppLocalizations.of(context).repeat),
      subtitle: enabled
          ? Text(AppLocalizations.of(context).autoRepeatDescription)
          : Text(AppLocalizations.of(context).noRepeatDescription),
      secondary: Icon(
        Icons.autorenew,
        color: enabled ? Theme.of(context).primaryColor : Colors.blueGrey,
      ),
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
      inactiveThumbColor: Colors.grey,
    );
  }
}
