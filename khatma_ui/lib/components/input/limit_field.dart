import 'package:flutter/material.dart';
import 'package:khatma_ui/components/input/number_field.dart';

class LimitField extends StatelessWidget {
  const LimitField({
    super.key,
    required this.label,
    required this.value,
    required this.maxValue,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int maxValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        NumberField(
          value: value,
          maxValue: maxValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
