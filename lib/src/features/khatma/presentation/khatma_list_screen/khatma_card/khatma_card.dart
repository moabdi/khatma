import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

import 'khatma_tile.dart';

/// Used to show a single khatma inside a card.
class KhatmaCard extends StatelessWidget {
  const KhatmaCard({super.key, required this.khatma, this.onPressed});
  final Khatma khatma;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const khatmaCardKey = Key('khatma-card');

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: KhatmaTile(khatma: khatma, onPressed: onPressed),
    );
  }
}
