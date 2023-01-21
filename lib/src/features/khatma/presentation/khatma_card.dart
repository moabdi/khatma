import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';

/// Used to show a single khatma inside a card.
class KhatmaCard extends StatelessWidget {
  const KhatmaCard({super.key, required this.khatma, this.onPressed});
  final Khatma khatma;
  final VoidCallback? onPressed;

  static const khatmaCardKey = Key('khatma-card');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        key: khatmaCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(khatma.name, style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
      ),
    );
  }
}
