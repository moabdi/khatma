import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_tile.dart';

class ShareOptions extends ConsumerWidget {
  const ShareOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    KhatmaShare khatmaShare = ref.watch(formShareProvider).khatmaShare;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(),
              shrinkWrap: true,
              itemCount: ShareVisibility.values.length,
              itemBuilder: (BuildContext context, int index) {
                var currentUnit = ShareVisibility.values[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ShareTile(
                    selected: khatmaShare.visibility == currentUnit,
                    currentUnit: currentUnit,
                    onSelect: (unit) {
                      ref
                          .read(formShareProvider.notifier)
                          .update(khatmaShare.copyWith(visibility: unit));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
