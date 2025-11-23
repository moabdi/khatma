import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

/// Primary and secondary action buttons
///
/// Can be reused for any screen requiring primary/secondary actions
class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPrimaryPressed,
            child: Text(primaryLabel),
          ),
        ),

        // Secondary button (if provided)
        if (secondaryLabel != null && onSecondaryPressed != null) ...[
          gapH12,
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onSecondaryPressed,
              child: Text(secondaryLabel!),
            ),
          ),
        ],
      ],
    );
  }
}
