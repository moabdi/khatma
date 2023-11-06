import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/data/parts_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';

class ReadPartTiles extends ConsumerWidget {
  const ReadPartTiles({
    super.key,
    required this.unit,
    required this.color,
    required this.completedParts,
  });

  final Color color;
  final SplitUnit unit;
  final List<KhatmaPart> completedParts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var partIds = completedParts
        .where((element) => element.finishedDate != null)
        .map((e) => e.id)
        .toList();

    return AsyncValueWidget(
      loading: const LoadingListTile(),
      value: ref.watch(partsListFutureProvider(unit)),
      data: (parts) {
        List<Part> filtredList =
            parts.where((part) => partIds.contains(part.id)).toList();

        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: filtredList.length,
          itemBuilder: (BuildContext context, int index) {
            var part = filtredList[index];
            var khatmaPart =
                completedParts.firstWhere((element) => element.id == part.id);
            return PartTile(
              part,
              enabled: false,
              color: color,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    khatmaPart.finishedDate!.format(),
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
