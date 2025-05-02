import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/read/logic/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/part_selector/part_tile_leading.dart';

class PartTile extends ConsumerWidget {
  const PartTile(
    this.part, {
    super.key,
    this.enabled = true,
    required this.color,
    this.trailing,
  });

  final Part part;
  final bool enabled;
  final Color color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected =
        ref.watch(khatmaPartsControllerProvider).contains(part.id);

    return ListTile(
      enabled: enabled,
      splashColor: color.withOpacity(.2),
      selected: isSelected,
      selectedColor: color,
      selectedTileColor: color.withOpacity(.1),
      onTap: () => toggleSelection(ref),
      leading: PartTileLeading(
        enabled: enabled,
        selected: isSelected,
        part: part,
        color: color,
      ),
      title: enabled
          ? Text(part.title)
          : Text(
              part.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
      subtitle: Text(
        part.subtitle,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: enabled
                  ? Theme.of(context).listTileTheme.subtitleTextStyle!.color
                  : Theme.of(context).hintColor,
            ),
      ),
      trailing: trailing,
    );
  }

  void toggleSelection(WidgetRef ref) {
    ref.read(khatmaPartsControllerProvider.notifier).selectPart(part.id);
  }
}
