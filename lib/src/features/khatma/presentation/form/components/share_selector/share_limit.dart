import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma_ui/components/input/incremental_field.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/string_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_controller.dart';

class ShareLimit extends ConsumerWidget {
  const ShareLimit({
    super.key,
    required this.khatmaShare,
    required this.maxValue,
  });

  final KhatmaShare khatmaShare;
  final int maxValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IncrementalField(
              label: AppLocalizations.of(context).maxPartToRead.colon,
              value: khatmaShare.maxPartToRead ?? 0,
              maxValue: maxValue,
              onChanged: (value) => ref
                  .read(shareControllerProvider.notifier)
                  .updateMaxPartToRead(value),
            ),
            gapH12,
            IncrementalField(
              label: AppLocalizations.of(context).maxPartToReserve.colon,
              value: khatmaShare.maxPartToReserve ?? 0,
              maxValue: maxValue,
              onChanged: (value) => ref
                  .read(shareControllerProvider.notifier)
                  .updateMaxPartToReserve(value),
            ),
          ],
        ),
      ),
    );
  }
}
