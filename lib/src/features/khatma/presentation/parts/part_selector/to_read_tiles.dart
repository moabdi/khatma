import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/widgets/async_value_widget.dart';
import 'package:khatma/src/common/widgets/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/application/part_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile.dart';
import 'package:khatma/src/routing/app_router.dart';

class ToReadPartTiles extends ConsumerWidget {
  const ToReadPartTiles({
    super.key,
    required this.unit,
    required this.color,
    required this.completedParts,
  });

  final Color color;
  final SplitUnit unit;
  final List<int> completedParts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncPartList = ref.watch(partsProvider(unit.name));
    return AsyncValueWidget(
      loading: const LoadingListTile(itemCount: 10),
      value: asyncPartList,
      data: (parts) {
        List<Part> filtredList =
            parts.where((part) => !completedParts.contains(part.id)).toList();

        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: filtredList.length,
          cacheExtent: 10,
          itemBuilder: (BuildContext context, int index) {
            var part = filtredList[index];
            return PartTile(
              part,
              color: color,
              trailing: CircleAvatar(
                backgroundColor: color.withOpacity(.2),
                child: IconButton(
                  icon: const Icon(Icons.auto_stories, size: 18),
                  color: color,
                  onPressed: () => handleOnTap(context, part),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void handleOnTap(BuildContext context, Part part) {
    context.pushNamed(AppRoute.quran.name, pathParameters: {
      'idSourat': part.start.sourat.toString(),
      'idVerset': part.start.verse.toString(),
    });
  }
}
