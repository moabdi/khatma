import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';

class KhatmaCompletude extends ConsumerWidget {
  const KhatmaCompletude({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(10),
      backgroundColor: khatma.style.hexColor.withAlpha(77),
      valueColor: AlwaysStoppedAnimation<Color>(khatma.style.hexColor),
      value: khatma.completionPercent,
    );
  }
}
