import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/part_selector/part_tile_leading.dart';
import 'package:khatma/src/features/khatma/presentation/part_selector/part_tile_subtitle.dart';
import 'package:khatma/src/features/khatma/presentation/part_selector/part_tile_title.dart';
import 'package:khatma/src/features/khatma/utils/collection_utils.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

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
      //enableFeedback: isSelected,
      tileColor: AppTheme.getTheme().backgroundColor,
      selectedTileColor: isRead
          ? AppTheme.getTheme().disabledColor
          : isSelected
              ? AppTheme.getTheme().primaryColor.withOpacity(0.13)
              : AppTheme.getTheme().backgroundColor,
      onLongPress: () => isRead
          ? null
          : ref?.read(selectedItemsNotifier.notifier).toggleSelection(part.id),
      onTap: () => CollectionUtils.isNotEmpty(selectedParts)
          ? ref?.read(selectedItemsNotifier.notifier).toggleSelection(part.id)
          : context.pushNamed(AppRoute.quran.name, params: {
              'idSourat': part.start.sourat.toString(),
              'idVerset': part.start.verse.toString(),
            }),
      leading:
          PartTileLeading(isRead: isRead, isSelected: isSelected, part: part),
      title: PartTileTitle(part: part, isRead: isRead),
      subtitle: PartTileSubtitle(part: part),
    );
  }
}
