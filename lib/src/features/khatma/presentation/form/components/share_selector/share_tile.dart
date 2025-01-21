import 'package:flutter/material.dart';
import 'package:khatma/src/common/extensions/share_visibility_icon.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class ShareTile extends StatelessWidget {
  const ShareTile({
    super.key,
    required this.selected,
    required this.value,
    required this.onSelect,
  });

  final bool selected;
  final ShareVisibility value;
  final ValueChanged<ShareVisibility> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final disabledColor = theme.disabledColor;

    return ListTile(
      selected: selected,
      title: Text(
        AppLocalizations.of(context).shareVisibility(value.name),
      ),
      subtitle: Text(
        AppLocalizations.of(context).shareVisibilityDesc(value.name),
      ),
      onTap: () => onSelect(value),
      leading: _buildAvatar(primaryColor, disabledColor, theme),
    );
  }

  Widget _buildAvatar(
      Color primaryColor, Color disabledColor, ThemeData theme) {
    return Avatar(
      radius: 30,
      backgroundColor:
          selected ? primaryColor.withOpacity(0.15) : disabledColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      bottom: selected
          ? Avatar(
              radius: 10,
              child: RadioIcon(selected: selected, size: 18),
            )
          : null,
      child: Icon(
        value.icon,
        color: primaryColor,
        size: 25,
      ),
    );
  }
}
