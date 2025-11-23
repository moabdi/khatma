import 'package:flutter/material.dart';

/// Section title widget with consistent styling
///
/// Displays a title with primary color and bold weight.
/// Perfect for section headers in forms or settings screens.
class SectionTitle extends StatelessWidget {
  const SectionTitle(
    this.title, {
    super.key,
    this.color,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: color ?? theme.colorScheme.primary,
      ),
    );
  }
}
