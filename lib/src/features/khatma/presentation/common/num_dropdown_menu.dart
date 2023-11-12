import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/custom_dropdown_menu.dart';

class NumberDropdownMenu extends StatelessWidget {
  NumberDropdownMenu(
      {super.key,
      this.value,
      this.onChanged,
      this.enabled = true,
      this.maxValue = 20});

  final int? value;
  final Function(int?)? onChanged;
  final bool enabled;
  final int maxValue;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      enabled: enabled,
      value: value,
      onChanged: onChanged,
      items: List.generate(maxValue, (index) => index + 1)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value", style: Theme.of(context).textTheme.bodyLarge),
        );
      }).toList(),
    );
  }
}
