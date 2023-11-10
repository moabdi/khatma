import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/custom_dropdown_menu.dart';

class NumberDropdownMenu extends StatelessWidget {
  NumberDropdownMenu({super.key, this.value, this.onChanged});

  final int? value;
  final Function(int?)? onChanged;
  final TextEditingController unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomDropdownMenu(
      value: value,
      onChanged: onChanged,
      items: List.generate(20, (index) => index + 1)
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value", style: Theme.of(context).textTheme.bodyLarge),
        );
      }).toList(),
    );
  }
}
