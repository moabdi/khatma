import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/extensions/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/num_dropdown_menu.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_controller.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';

class ShareLimit extends ConsumerWidget {
  const ShareLimit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Khatma khatma = ref.watch(formKhatmaProvider);
    KhatmaShare khatmaShare = ref.watch(shareNotifierProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                gapW8,
                Text(AppLocalizations.of(context).maxPartToReserve.colon,
                    style: Theme.of(context).textTheme.bodyLarge),
                gapW8,
                NumberDropdownMenu(
                  enabled: khatmaShare.visibility != ShareVisibility.private,
                  maxValue: khatma.unit.count,
                  value: khatmaShare.maxPartToReserve ?? 1,
                  onChanged: (value) => ref
                      .read(shareControllerProvider.notifier)
                      .updateMaxPartToReserve(value),
                ),
              ],
            ),
            gapH12,
            Row(
              children: [
                gapW8,
                Text(AppLocalizations.of(context).maxPartToRead.colon,
                    style: Theme.of(context).textTheme.bodyLarge),
                gapW8,
                NumberDropdownMenu(
                  enabled: khatmaShare.visibility != ShareVisibility.private,
                  maxValue: khatma.unit.count,
                  value: khatmaShare.maxPartToRead ?? 1,
                  onChanged: (value) => ref
                      .read(shareControllerProvider.notifier)
                      .updateMaxPartToRead(value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
