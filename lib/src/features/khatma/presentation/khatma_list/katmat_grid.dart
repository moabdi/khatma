import 'dart:math';

import 'package:khatma_app/src/common_widgets/async_value_widget.dart';
import 'package:khatma_app/src/features/khatma/data/fake_khatma_repository.dart';
import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:khatma_app/src/features/khatma/presentation/khatma_list/khatma_card.dart';
import 'package:khatma_app/src/localization/string_hardcoded.dart';
import 'package:khatma_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:khatma_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays the list of khatmas that match the search query.
class KhatmatGrid extends ConsumerWidget {
  const KhatmatGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatmatListValue = ref.watch(khatmasListStreamProvider);
    return AsyncValueWidget<List<Khatma>>(
      value: khatmatListValue,
      data: (khatmat) => khatmat.isEmpty
          ? Center(
              child: Text(
                'No khatma found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : KhatmatLayoutGrid(
              itemCount: khatmat.length,
              itemBuilder: (_, index) {
                final khatma = khatmat[index];
                return KhatmaCard(
                  khatma: khatma,
                  onPressed: () => context.goNamed(
                    AppRoute.khatma.name,
                    params: {'id': khatma.id!},
                  ),
                );
              },
            ),
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class KhatmatLayoutGrid extends StatelessWidget {
  const KhatmatLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p8, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
