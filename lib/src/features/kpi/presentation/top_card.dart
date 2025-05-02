import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
    );
  }

  Widget buildIndicator({
    required Icon icon,
    required String title,
    required int count,
    required BuildContext context, // 👈 Needed for Theme access
  }) {
    final theme = Theme.of(context); // 👈 Use context-provided theme

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: theme.colorScheme.background.withOpacity(0.5),
          radius: 25,
          child: icon,
        ),
        Text(
          count.toString(),
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
