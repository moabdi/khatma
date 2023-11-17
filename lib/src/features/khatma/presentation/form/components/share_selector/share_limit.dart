import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/num_dropdown_menu.dart';

class ShareLimit extends ConsumerWidget {
  const ShareLimit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Khatma khatma = ref.watch(formKhatmaProvider).khatma;
    KhatmaShare khatmaShare = ref.watch(formShareProvider).khatmaShare;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                gapW8,
                Text(AppLocalizations.of(context).maxPartToReserve.withColon,
                    style: Theme.of(context).textTheme.bodyLarge),
                gapW8,
                NumberDropdownMenu(
                  enabled: khatmaShare.visibility != ShareVisibility.private,
                  maxValue: khatma.unit.count,
                  value: khatmaShare.maxPartToReserve ?? 1,
                  onChanged: (value) {
                    if (khatmaShare.maxPartToRead == null ||
                        value! > khatmaShare.maxPartToRead!) {
                      ref.read(formShareProvider.notifier).update(
                          khatmaShare.copyWith(
                              maxPartToReserve: value, maxPartToRead: value));
                    } else {
                      ref.read(formShareProvider.notifier).update(
                          khatmaShare.copyWith(maxPartToReserve: value));
                    }
                  },
                ),
              ],
            ),
            gapH12,
            Row(
              children: [
                gapW8,
                Text(AppLocalizations.of(context).maxPartToRead.withColon,
                    style: Theme.of(context).textTheme.bodyLarge),
                gapW8,
                NumberDropdownMenu(
                  enabled: khatmaShare.visibility != ShareVisibility.private,
                  maxValue: khatma.unit.count,
                  value: khatmaShare.maxPartToRead ?? 1,
                  onChanged: (value) {
                    if (khatmaShare.maxPartToReserve == null ||
                        value! < khatmaShare.maxPartToReserve!) {
                      ref.read(formShareProvider.notifier).update(
                          khatmaShare.copyWith(
                              maxPartToReserve: value, maxPartToRead: value));
                    } else {
                      ref
                          .read(formShareProvider.notifier)
                          .update(khatmaShare.copyWith(maxPartToRead: value));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
