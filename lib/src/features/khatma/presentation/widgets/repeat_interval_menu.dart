import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma_ui/components/menu/custom_dropdown_menu.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RepeatIntervalDropdownMenu extends StatelessWidget {
  const RepeatIntervalDropdownMenu(
      {super.key, this.selectedUnit, this.onSelected, this.enabled = true});

  final RepeatInterval? selectedUnit;
  final Function(RepeatInterval?)? onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      enabled: enabled,
      value: selectedUnit ?? RepeatInterval.auto,
      onChanged: onSelected,
      items: RepeatInterval.values
          .map<DropdownMenuItem<RepeatInterval>>((RepeatInterval value) {
        return DropdownMenuItem<RepeatInterval>(
          value: value,
          child: Text(AppLocalizations.of(context).repeatInterval(value.name),
              style: Theme.of(context).textTheme.bodyLarge),
        );
      }).toList(),
    );
  }
}
