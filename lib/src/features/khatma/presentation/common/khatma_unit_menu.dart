import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitDropdownMenu extends StatelessWidget {
  UnitDropdownMenu({super.key, this.selectedUnit, this.onSelected});

  final RecurrenceUnit? selectedUnit;
  final Function(RecurrenceUnit?)? onSelected;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<RecurrenceUnit>> entries =
        <DropdownMenuEntry<RecurrenceUnit>>[];
    for (final RecurrenceUnit unit in RecurrenceUnit.values) {
      entries.add(
        DropdownMenuEntry<RecurrenceUnit>(
            value: unit,
            label: AppLocalizations.of(context).recurrenceUnit(unit.name)),
      );
    }

    return DropdownMenu<RecurrenceUnit>(
      textStyle: AppTheme.getTheme().textTheme.titleSmall,
      initialSelection: selectedUnit ?? RecurrenceUnit.month,
      controller: unitController,
      dropdownMenuEntries: entries,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
      onSelected: onSelected,
    );
  }
}
