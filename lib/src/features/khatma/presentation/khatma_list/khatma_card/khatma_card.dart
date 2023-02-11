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
      shadowColor: AppTheme.getTheme().disabledColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
        side: BorderSide(
          color: AppTheme.getTheme().disabledColor,
          width: 1.0,
        ),
      ),
      child: SizedBox(
        height: 110,
        child: KhatmaTile(khatma: khatma, onPressed: onPressed),
      ),
    );
  }
}
