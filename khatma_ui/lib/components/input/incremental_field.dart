import 'package:flutter/material.dart';
import 'package:khatma_ui/components/buttons/adjust_number_button.dart';
import 'package:khatma_ui/components/buttons/decrement_number_button.dart';
import 'package:khatma_ui/components/buttons/increment_number_button.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class IncrementalField extends StatelessWidget {
  const IncrementalField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 100,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;
  final int? maxValue;

  void _increment() {
    if (maxValue == null || value < maxValue!) {
      onChanged(value + 1);
    }
  }

  void _decrement() {
    if (value > minValue) {
      onChanged(value - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (value > 0) ...[
              _buildDecrementButton(),
              gapW12,
              Text(
                "$value",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              gapW12,
            ],
            IncrementNumberButton(onPressed: _increment),
          ],
        ),
      ],
    );
  }

  Widget _buildDecrementButton() {
    if (value == 1) {
      return AdjustNumberButton(
        backgroundColor: Colors.transparent,
        icon: const Icon(Icons.delete),
        onPressed: _decrement,
      );
    }
    return DecrementNumberButton(onPressed: _decrement);
  }
}
