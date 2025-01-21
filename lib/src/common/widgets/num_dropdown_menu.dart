import 'package:flutter/material.dart';
import 'package:khatma_ui/components/menu/custom_dropdown_menu.dart';

class NumDropdownMenu extends StatelessWidget {
  NumDropdownMenu({
    super.key,
    this.value,
    this.onChanged,
    this.maxValue = 10,
    this.minValue = 1,
  });

  final int? value;
  final Function(int?)? onChanged;
  final int maxValue;
  final int minValue;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      value: value,
      onChanged: onChanged,
      items: List.generate(99, (index) => index + 1)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
