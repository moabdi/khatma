import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_parts_screen/part_selector/part_tile_leading.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_parts_screen/part_selector/part_tile_subtitle.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_parts_screen/part_selector/part_tile_title.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma/src/routing/app_router.dart';

class PartTile extends StatelessWidget {
  const PartTile(this.part,
      {super.key, this.ref, this.selectedParts, this.isRead = false});

  final List<int>? selectedParts;
  final Part part;
  final WidgetRef? ref;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedParts!.contains(part.id);
    return ListTile(
      enabled: !isRead,
      selected: isSelected,
      onLongPress: toggleSelection,
      onTap: () => handleOnTap(context),
      leading:
          PartTileLeading(isRead: isRead, isSelected: isSelected, part: part),
      title: PartTileTitle(part: part, isRead: isRead),
      subtitle: PartTileSubtitle(part: part),
    );
  }

  void toggleSelection() =>
      ref?.read(selectedItemsNotifier.notifier).toggleSelection(part.id);

  void handleOnTap(BuildContext context) {
    if (CollectionUtils.isNotEmpty(selectedParts)) {
      toggleSelection();
    } else {
      context.pushNamed(AppRoute.quran.name, pathParameters: {
        'idSourat': part.start.sourat.toString(),
        'idVerset': part.start.verse.toString(),
      });
    }
  }
}
