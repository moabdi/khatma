import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';

class RepeatEnablerTile extends ConsumerWidget {
  const RepeatEnablerTile({super.key, this.enabled = true, this.onChanged});

  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(AppLocalizations.of(context).repeat),
      subtitle: enabled
          ? Text(AppLocalizations.of(context).autoRepeatDescription)
          : Text(AppLocalizations.of(context).noRepeatDescription),
      leading: _buildLeading(context),
      trailing: Switch(value: enabled, onChanged: onChanged),
      onTap: () {
        if (onChanged != null) {
          onChanged!(!enabled);
        }
      },
    );
  }

  Avatar _buildLeading(BuildContext context) {
    return Avatar(
      radius: 30,
      backgroundColor: Theme.of(context).disabledColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.autorenew,
        color: Theme.of(context).primaryColor,
        size: 25,
      ),
    );
  }
}
