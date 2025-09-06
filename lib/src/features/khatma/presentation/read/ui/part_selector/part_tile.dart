import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/presentation/read/logic/khatma_parts_controller.dart';
import 'package:khatma/src/features/khatma/presentation/read/ui/part_selector/part_tile_leading.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/i18n/local_provider.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTile extends ConsumerWidget {
  const PartTile(
    this.part, {
    super.key,
    this.enabled = true,
    required this.color,
    required this.unit,
    this.trailing,
  });

  final Part part;
  final bool enabled;
  final Color color;
  final Widget? trailing;
  final SplitUnit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected =
        ref.watch(khatmaPartsControllerProvider).contains(part.id);

    final selectedLocale = ref.read(localeProvider).languageCode;

    var partSubtitle = '${part.subtitle} - ${part.transliteration}';
    var partTitle =
        "${context.loc.ordinalPartNumber(part.id.toString())} ${context.loc.khatmaSplitUnit(unit.name)}";

    if (selectedLocale == 'ar') {
      partSubtitle = '${part.name} - ${part.subname}';
      partTitle =
          "${context.loc.khatmaSplitUnitWithDef(unit.name)} ${context.loc.ordinalPartNumber(part.id.toString())}";
    }

    return ListTile(
      dense: true,
      enabled: enabled,
      splashColor: color.withAlpha(51),
      selected: isSelected,
      selectedColor: color,
      selectedTileColor: color.withAlpha(26),
      onTap: () => toggleSelection(ref),
      leading: PartTileLeading(
        enabled: enabled,
        selected: isSelected,
        part: part,
        color: color,
      ),
      title: Text(
        partTitle,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        partSubtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
      // trailing: trailing,
    );
  }

  void toggleSelection(WidgetRef ref) {
    ref.read(khatmaPartsControllerProvider.notifier).togglePart(part.id);
  }
}
