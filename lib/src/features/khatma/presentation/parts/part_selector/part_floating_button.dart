import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma/src/themes/theme.dart';

class PartFloatingButton extends StatelessWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
  });
  final String? khatmaId;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final selectedParts = ref.watch(selectedItemsNotifier);
      return CollectionUtils.isEmpty(selectedParts)
          ? Container()
          : FloatingActionButton.extended(
              extendedTextStyle: AppTheme.getTheme().textTheme.titleMedium,
              onPressed: () {
                ref
                    .read(khatmasRepositoryProvider)
                    .masrAsReadParts(khatmaId, selectedParts);
                ref.read(selectedItemsNotifier.notifier).initSelection([]);
              },
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Marquer comme lu (${selectedParts.length})',
                ),
              ),
              icon: const Icon(Icons.check),
              backgroundColor: AppTheme.getTheme().primaryColor,
            );
    });
  }
}
