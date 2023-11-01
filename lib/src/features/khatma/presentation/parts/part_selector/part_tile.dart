import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/data/selected_items_notifier.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_leading.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_subtitle.dart';
import 'package:khatma/src/features/khatma/presentation/parts/part_selector/part_tile_title.dart';
import 'package:khatma/src/routing/app_router.dart';

class PartTile extends ConsumerWidget {
  const PartTile(this.part,
      {super.key,
      this.selectedParts,
      this.isRead = false,
      required this.color});

  final List<int>? selectedParts;
  final Part part;
  final bool isRead;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = selectedParts!.contains(part.id);
    return ListTile(
      dense: true,
      enabled: !isRead,
      splashColor: color.withOpacity(.2),
      selected: isSelected,
      selectedColor: color,
      selectedTileColor: color.withOpacity(.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      minVerticalPadding: 0,
      onTap: () => toggleSelection(ref),
      leading: PartTileLeading(
        isRead: isRead,
        isSelected: isSelected,
        part: part,
        color: color,
      ),
      title: PartTileTitle(part: part, isRead: isRead),
      subtitle: PartTileSubtitle(part: part),
      trailing: CircleAvatar(
        backgroundColor: color.withOpacity(.2),
        child: IconButton(
          icon: const Icon(Icons.auto_stories, size: 18),
          color: color,
          onPressed: () => handleOnTap(context),
        ),
      ),
    );
  }

  void toggleSelection(WidgetRef ref) =>
      ref.read(selectedItemsNotifier.notifier).toggleSelection(part.id);

  void handleOnTap(BuildContext context) {
    context.pushNamed(AppRoute.quran.name, pathParameters: {
      'idSourat': part.start.sourat.toString(),
      'idVerset': part.start.verse.toString(),
    });
  }
}
