import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class NumberDropdownMenu extends StatelessWidget {
  const NumberDropdownMenu({
    super.key,
    this.initialValue,
    this.maxValue = 10,
    this.minValue = 1,
    this.width = 90,
    this.onSelected,
  });

  final int? initialValue;
  final int maxValue;
  final int minValue;
  final double width;
  final Function(int?)? onSelected;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<int>> entries = <DropdownMenuEntry<int>>[];
    for (int unit = minValue; unit <= maxValue; unit++) {
      entries.add(
        DropdownMenuEntry<int>(
          value: unit,
          label: unit.toString(),
        ),
      );
    }

    return DropdownMenu<int>(
      width: width,
      textStyle: AppTheme.getTheme().textTheme.titleSmall,
      initialSelection: initialValue ?? 1,
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
