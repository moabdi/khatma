import 'package:flutter/material.dart';
import 'package:khatma_ui/components/buttons/adjust_number_button.dart';

class IncrementNumberButton extends StatelessWidget {
  const IncrementNumberButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AdjustNumberButton(
      icon: const Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
