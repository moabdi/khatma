import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_leading.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_subtitle.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_title.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_trailing.dart';
import 'package:khatma/src/routing/app_router.dart';

class PartTile extends ConsumerWidget {
  const PartTile(
    this.part, {
    super.key,
    this.enabled = true,
    required this.color,
  });

  final Part part;
  final bool enabled;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectedItemsNotifier).contains(part.id);

    return ListTile(
      enabled: enabled,
      splashColor: color.withOpacity(.2),
      selected: isSelected,
      selectedColor: color,
      selectedTileColor: color.withOpacity(.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      minVerticalPadding: 0,
      onTap: () => toggleSelection(ref),
      leading: PartTileLeading(
        enabled: enabled,
        selected: isSelected,
        part: part,
        color: color,
      ),
      title: PartTileTitle(part: part, enabled: enabled),
      subtitle: PartTileSubtitle(part: part),
      trailing: PartTileTrailing(
        enabled: enabled,
        color: color,
        onPressed: () => handleOnTap(context),
      ),
    );
  }

  void toggleSelection(WidgetRef ref) {
    ref.read(selectedItemsNotifier.notifier).toggleSelection(part.id);
  }

  void handleOnTap(BuildContext context) {
    context.pushNamed(AppRoute.quran.name, pathParameters: {
      'idSourat': part.start.sourat.toString(),
      'idVerset': part.start.verse.toString(),
    });
  }
}
