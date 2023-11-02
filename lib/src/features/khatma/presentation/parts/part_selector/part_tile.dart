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

class PartTile extends ConsumerStatefulWidget {
  const PartTile(
    this.part, {
    super.key,
    this.selected = false,
    this.isRead = false,
    required this.color,
  });

  final Part part;
  final bool selected;
  final bool isRead;
  final Color color;

  @override
  ConsumerState<PartTile> createState() => _PartTileState();
}

class _PartTileState extends ConsumerState<PartTile> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !widget.isRead,
      splashColor: widget.color.withOpacity(.2),
      selected: isSelected,
      selectedColor: widget.color,
      selectedTileColor: widget.color.withOpacity(.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      minVerticalPadding: 0,
      onTap: () => toggleSelection(ref),
      leading: PartTileLeading(
        isRead: widget.isRead,
        isSelected: isSelected,
        part: widget.part,
        color: widget.color,
      ),
      title: PartTileTitle(part: widget.part, isRead: widget.isRead),
      subtitle: PartTileSubtitle(part: widget.part),
      trailing: PartTileTrailing(
        isRead: widget.isRead,
        color: widget.color,
        onPressed: () => handleOnTap(context),
      ),
    );
  }

  void toggleSelection(WidgetRef ref) {
    setState(() {
      isSelected = !isSelected;
    });
    ref.read(selectedItemsNotifier.notifier).toggleSelection(widget.part.id);
  }

  void handleOnTap(BuildContext context) {
    context.pushNamed(AppRoute.quran.name, pathParameters: {
      'idSourat': widget.part.start.sourat.toString(),
      'idVerset': widget.part.start.verse.toString(),
    });
  }
}
