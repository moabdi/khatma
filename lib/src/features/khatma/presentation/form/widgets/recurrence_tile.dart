import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RecurrenceTile extends StatelessWidget {
  const RecurrenceTile(
      {super.key,
      required this.value,
      required this.icon,
      required this.selectedValue,
      required this.onTap});

  final KhatmaScheduler value;
  final Widget icon;
  final KhatmaScheduler selectedValue;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedValue == value;

    return ListTile(
      selected: isSelected,
      leading: RadioIcon(selected: isSelected),
      title: Text(AppLocalizations.of(context).khatmaScheduler(value.name)),
      subtitle: Text(
          AppLocalizations.of(context).khatmaSchedulerDescription(value.name)),
      onTap: onTap,
    );
  }
}
