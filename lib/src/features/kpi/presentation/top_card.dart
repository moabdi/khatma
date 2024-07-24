import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
    );
  }

  Widget buildIndicator(
      {required Icon icon, required String title, required int count}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              AppTheme.getTheme().colorScheme.background.withOpacity(0.5),
          radius: 25,
          child: icon,
        ),
        Text(
          count.toString(),
          style: AppTheme.getTheme()
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
