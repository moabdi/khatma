import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';

class PartFloatingButton extends ConsumerWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
    required this.color,
  });
  final String? khatmaId;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedParts = ref.watch(selectedItemsNotifier);
    return CollectionUtils.isEmpty(selectedParts)
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 10,
                  blurRadius: 100,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => _onSubmit(ref, selectedParts),
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
              icon: const Icon(Icons.check, size: 18),
              label: Text(AppLocalizations.of(context)
                  .completeParts(selectedParts.length)),
            ),
          );
  }

  _onSubmit(WidgetRef ref, List<int> selectedParts) {
    ref.read(khatmasRepositoryProvider).markAsRead(khatmaId, selectedParts);
    ref.read(formKhatmaProvider).markPartAsRead(selectedParts);
    ref.read(selectedItemsNotifier.notifier).initSelection([]);
  }
}
