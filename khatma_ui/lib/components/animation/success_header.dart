import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Success header with Lottie animation and text
///
/// Displays a success animation with title and optional subtitle.
/// Can be reused in any success/completion screen.
class SuccessHeader extends StatelessWidget {
  const SuccessHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.animationAsset = 'assets/lottie/success.json',
    this.animationSize = 150.0,
  });

  final String title;
  final String? subtitle;
  final String animationAsset;
  final double animationSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Success animation
        Lottie.asset(
          animationAsset,
          width: animationSize,
          height: animationSize,
          repeat: false,
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),

        // Optional subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
