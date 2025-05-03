import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/widgets/async_value_widget.dart';
import 'package:khatma_ui/components/loading_list_tile.dart';
import 'package:khatma/src/features/khatma/application/part_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/part_selector/part_tile.dart';
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
          itemBuilder: (context, index) {
            final part = filtredList[index];
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 500 + index * 50),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: PartTile(
                      part,
                      color: color,
                      trailing: CircleAvatar(
                        backgroundColor: color.withAlpha(51),
                        child: IconButton(
                          icon: const Icon(Icons.auto_stories, size: 18),
                          color: color,
                          onPressed: () => handleOnTap(context, part),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
