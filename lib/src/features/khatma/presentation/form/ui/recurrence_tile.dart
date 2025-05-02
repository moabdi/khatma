import 'package:flutter/material.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma_ui/components/avatar.dart';
import 'package:khatma_ui/components/radio_icon.dart';

class RecurrenceTile extends StatelessWidget {
  const RecurrenceTile({super.key, required this.value, required this.onTap});

  final bool value;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    Map<bool, IconData> unitIcons = {
      false: Icons.block_flipped,
      true: Icons.autorenew
    };

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      selected: value,
      leading: Avatar(
        radius: 30,
        backgroundColor: value
            ? Theme.of(context).primaryColor.withOpacity(.15)
            : Theme.of(context).disabledColor,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        bottom: value
            ? Avatar(radius: 10, child: RadioIcon(selected: value, size: 18))
            : null,
        child: Icon(
          unitIcons[value],
          color: Theme.of(context).primaryColor,
          size: 25,
        ),
      ),
      title: Text(AppLocalizations.of(context).repeatOption(value.toString())),
      subtitle: Text(
        AppLocalizations.of(context).repeatOption(value.toString()),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: onTap,
    );
  }
}
