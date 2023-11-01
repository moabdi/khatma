import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class ShareSelector extends StatelessWidget {
  const ShareSelector(
      {super.key, this.unit = KhatmaShareType.private, required this.onSelect});
  final KhatmaShareType unit;
  final ValueChanged<KhatmaShareType> onSelect;

  @override
  Widget build(BuildContext context) {
    List<Icon> icons = const [
      Icon(FontAwesomeIcons.lock, color: Colors.orange),
      Icon(Icons.public, color: Colors.blue),
      Icon(Icons.group, color: Colors.purple),
    ];
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(),
      shrinkWrap: true,
      itemCount: KhatmaShareType.values.length,
      itemBuilder: (BuildContext context, int index) {
        var currentUnit = KhatmaShareType.values[index];
        var selected = unit == currentUnit;
        return ShareTile(
            selected: selected,
            currentUnit: currentUnit,
            icon: icons[index],
            onSelect: onSelect);
      },
    );
  }
}

class ShareTile extends StatelessWidget {
  const ShareTile({
    super.key,
    required this.selected,
    required this.currentUnit,
    required this.icon,
    required this.onSelect,
  });

  final bool selected;
  final KhatmaShareType currentUnit;
  final Icon icon;
  final ValueChanged<KhatmaShareType> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      title:
          Text(AppLocalizations.of(context).khatmaShareType(currentUnit.name)),
      subtitle: Text(AppLocalizations.of(context)
          .khatmaShareTypeDescription(currentUnit.name)),
      onTap: () {
        Navigator.pop(context);
        onSelect(currentUnit);
      },
      leading: RadioIcon(selected: selected),
    );
  }
}
