import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';

class PartFloatingButton extends StatelessWidget {
  const PartFloatingButton({
    super.key,
    this.khatmaId,
    required this.color,
  });
  final String? khatmaId;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final selectedParts = ref.watch(selectedItemsNotifier);
      return CollectionUtils.isEmpty(selectedParts)
          ? Container()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color ?? Theme.of(context).primaryColor,
              ),
              onPressed: () {
                ref
                    .read(khatmasRepositoryProvider)
                    .markAsRead(khatmaId, selectedParts);
                ref.read(selectedItemsNotifier.notifier).initSelection([]);
              },
              child: Text('Marquer comme lu (${selectedParts.length})'),
            );
    });
  }
}
