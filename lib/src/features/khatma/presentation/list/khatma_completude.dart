import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaCompletude extends ConsumerWidget {
  const KhatmaCompletude({
    super.key,
    required this.khatma,
  });

  final Khatma khatma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsList = ref.watch(partsListFutureProvider(khatma.unit));
    // for visibility
    return AsyncValueWidget<List<Part>>(
      value: partsList,
      data: (parts) => LinearProgressIndicator(
        borderRadius: BorderRadius.circular(10),
        backgroundColor: AppTheme.getTheme().disabledColor,
        valueColor: AlwaysStoppedAnimation<Color>(khatma.style.hexColor),
        value: khatma.completude,
      ),
    );
  }
}
