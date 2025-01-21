import 'package:flutter/material.dart';
import 'package:khatma_ui/components/buttons/adjust_number_button.dart';

class DecrementNumberButton extends StatelessWidget {
  const DecrementNumberButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AdjustNumberButton(
      icon: const Icon(Icons.remove),
      onPressed: onPressed,
    );
  }
}
