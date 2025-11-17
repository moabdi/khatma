import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/widgets/async_value_widget.dart';
import 'package:khatma_ui/components/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/personal/application/part_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_part.dart';
import 'package:khatma/src/features/khatma/personal/presentation/read/ui/part_selector/part_tile.dart';

class ReadPartTiles extends ConsumerWidget {
  const ReadPartTiles({
    super.key,
    required this.unit,
    required this.color,
    required this.partIds,
  });

  final Color color;
  final SplitUnit unit;
  final List<int> partIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AsyncValueWidget(
      loading: const LoadingListTile(),
      value: ref.watch(partsProvider(unit.name)),
      data: (parts) {
        List<Part> filtredList =
            parts.where((part) => partIds.contains(part.id)).toList();

        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => const Divider(
            height: 2,
            color: Colors.white,
          ),
          itemCount: filtredList.length,
          itemBuilder: (BuildContext context, int index) {
            var part = filtredList[index];
            return PartTile(
              part,
              enabled: false,
              unit: unit,
              color: color,
            );
          },
        );
      },
    );
  }
}
