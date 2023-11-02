import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';

class UnReadPartTiles extends ConsumerWidget {
  const UnReadPartTiles({
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
    var asyncPartList = ref.watch(partsListFutureProvider(unit));
    return AsyncValueWidget(
      value: asyncPartList,
      data: (parts) {
        List<Part> filtredList =
            parts.where((part) => !completedParts!.contains(part.id)).toList();
        List<int> selectedParts = ref.read(selectedItemsNotifier);
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: filtredList.length,
          cacheExtent: 10,
          itemBuilder: (BuildContext context, int index) {
            var part = filtredList[index];
            print('part.id: ${part.id}');
            return PartTile(
              part,
              selected: selectedParts.contains(part.id),
              color: color,
            );
          },
        );
      },
    );
  }
}
