import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class NumberDropdownMenu extends StatelessWidget {
  NumberDropdownMenu({super.key, this.selectedUnit, this.onSelected});

  final int? selectedUnit;
  final Function(int?)? onSelected;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<int>> entries = <DropdownMenuEntry<int>>[];
    for (int unit = 1; unit <= 10; unit++) {
      entries.add(
        DropdownMenuEntry<int>(
          value: unit,
          label: unit.toString(),
        ),
      );
    }

    return DropdownMenu<int>(
      width: 90,
      textStyle: AppTheme.getTheme().textTheme.titleSmall,
      initialSelection: selectedUnit ?? 1,
      controller: unitController,
      dropdownMenuEntries: entries,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).disabledColor,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      onSelected: onSelected,
    );
  }
}
