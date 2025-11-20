import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:lottie/lottie.dart';

/// Success header with animation and title
///
/// Can be reused in any success/completion screen
class SuccessHeader extends StatelessWidget {
  const SuccessHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Success animation
        Lottie.asset(
          'assets/lottie/success.json',
          width: 150,
          height: 150,
          repeat: false,
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),

        // Optional subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
