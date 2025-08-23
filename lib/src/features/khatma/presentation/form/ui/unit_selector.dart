import 'package:flutter/material.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma_ui/components/avatar.dart';
import 'package:khatma_ui/components/radio_icon.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key, required this.unit, required this.onSelect});
  final SplitUnit unit;
  final ValueChanged<SplitUnit> onSelect;

  @override
  Widget build(BuildContext context) {
    Map<SplitUnit, IconData> unitIcons = {
      SplitUnit.juzz: Icons.bookmarks,
      SplitUnit.hizb: Icons.bookmark,
    };
    return Card(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: SplitUnit.values.length,
            itemBuilder: (BuildContext context, int index) {
              var currentUnit = SplitUnit.values[index];
              var selected = unit == currentUnit;
              return Padding(
                padding: const EdgeInsets.all(3),
                child: ListTile(
                  minVerticalPadding: 0,
                  selected: selected,
                  title: Text(AppLocalizations.of(context)
                      .khatmaSplitUnit(currentUnit.name)),
                  subtitle: Text(AppLocalizations.of(context)
                      .khatmaSplitUnitDesc(currentUnit.name)),
                  leading: Avatar(
                    radius: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    bottom: selected
                        ? Avatar(
                            radius: 10,
                            child: RadioIcon(selected: selected, size: 18))
                        : null,
                    child: Icon(
                      unitIcons[currentUnit],
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(currentUnit);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
