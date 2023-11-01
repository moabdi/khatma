import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';

class UnreadPartTiles extends ConsumerWidget {
  const UnreadPartTiles({
    super.key,
    required this.unit,
    required this.color,
    this.completedParts,
  });

  final Color color;
  final SplitUnit unit;
  final List<int>? completedParts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsListValue = ref.read(partsListFutureProvider(unit));
    List<int> selectedParts = ref.watch(selectedItemsNotifier);
    return AsyncValueWidget<List<Part>>(
      value: partsListValue,
      data: (parts) {
        parts.removeWhere((part) => completedParts?.contains(part.id) ?? false);
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: parts.length,
          itemBuilder: (BuildContext context, int index) {
            var part = parts[index];
            return PartTile(
              part,
              selectedParts: selectedParts,
              isRead: false,
              color: color,
            );
          },
        );
      },
    );
  }
}
