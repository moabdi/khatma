import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';

/// Used to show a single khatma inside a card.
class KhatmaCard extends StatelessWidget {
  const KhatmaCard({super.key, required this.khatma, this.onPressed});
  final Khatma khatma;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const khatmaCardKey = Key('khatma-card');

  @override
  Widget build(BuildContext context) {
    // TODO: Inject formatter
    return Card(
      child: InkWell(
        key: khatmaCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(khatma.title, style: Theme.of(context).textTheme.headline6),
              gapH24,
              Text(
                khatma.availableQuantity <= 0
                    ? 'Out of Stock'.hardcoded
                    : 'Quantity: ${khatma.availableQuantity}'.hardcoded,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
