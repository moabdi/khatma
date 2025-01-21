import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_utils.dart';
import 'package:khatma/src/themes/theme.dart';

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
      backgroundColor: AppTheme.getTheme().disabledColor,
      valueColor: AlwaysStoppedAnimation<Color>(khatma.style.hexColor),
      value: khatma.completude,
    );
  }
}
