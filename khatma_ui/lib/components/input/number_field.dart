import 'package:flutter/material.dart';
import 'package:khatma_ui/components/buttons/adjust_number_button.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 100,
  });

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
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade100,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AdjustNumberButton(
            backgroundColor: Colors.transparent,
            icon: const Icon(
              Icons.remove,
              weight: 40,
            ),
            onPressed: _decrement,
          ),
          gapW12,
          Text(
            "$value",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          gapW12,
          AdjustNumberButton(
            backgroundColor: Colors.transparent,
            icon: const Icon(Icons.add),
            onPressed: _increment,
          )
        ],
      ),
    );
  }
}
