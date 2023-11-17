import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class ShareTile extends StatelessWidget {
  const ShareTile({
    super.key,
    required this.selected,
    required this.currentUnit,
    required this.onSelect,
  });

  final bool selected;
  final ShareVisibility currentUnit;
  final ValueChanged<ShareVisibility> onSelect;

  @override
  Widget build(BuildContext context) {
    Map<ShareVisibility, IconData> shareIcons = {
      ShareVisibility.private: Icons.lock,
      ShareVisibility.group: Icons.groups,
      ShareVisibility.public: Icons.public,
    };

    return ListTile(
      selected: selected,
      title:
          Text(AppLocalizations.of(context).shareVisibility(currentUnit.name)),
      subtitle: Text(
        AppLocalizations.of(context).shareVisibilityDesc(currentUnit.name),
      ),
      onTap: () {
        onSelect(currentUnit);
      },
      leading: Avatar(
        radius: 30,
        backgroundColor: selected
            ? Theme.of(context).primaryColor.withOpacity(.15)
            : Theme.of(context).disabledColor,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        bottom: selected
            ? Avatar(radius: 10, child: RadioIcon(selected: selected, size: 18))
            : null,
        child: Icon(
          shareIcons[currentUnit],
          color: Theme.of(context).primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
