import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
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
    double opacity = khatma.completude < .3 ? 0.3 : khatma.completude;
    return AsyncValueWidget<List<Part>>(
      value: partsList,
      data: (parts) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                parts[khatma.nextPartToRead - 1].title.toString(),
                style: AppTheme.getTheme().textTheme.labelSmall,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                khatma.completude <= 0
                    ? ""
                    : "${(khatma.completude * 100).toStringAsFixed(0)}%",
                style: AppTheme.getTheme().textTheme.titleSmall,
              ),
            ],
          ),
          gapH4,
          LinearProgressIndicator(
            backgroundColor: AppTheme.getTheme().disabledColor.withOpacity(.8),
            valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.getTheme().primaryColor.withOpacity(opacity)),
            value: khatma.completude,
          ),
        ],
      ),
    );
  }
}
