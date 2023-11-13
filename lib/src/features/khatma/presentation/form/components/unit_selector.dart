import 'package:flutter/material.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key, required this.unit, required this.onSelect});
  final SplitUnit unit;
  final ValueChanged<SplitUnit> onSelect;

  @override
  Widget build(BuildContext context) {
    Map<SplitUnit, IconData> unitIcons = {
      SplitUnit.sourat: Icons.brightness_5,
      SplitUnit.juzz: Icons.bookmarks,
      SplitUnit.hizb: Icons.bookmark,
      SplitUnit.half: Icons.contrast,
      SplitUnit.rubue: Icons.filter_4,
      SplitUnit.thumun: Icons.filter_8,
    };
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: SplitUnit.values.length,
              itemBuilder: (BuildContext context, int index) {
                var currentUnit = SplitUnit.values[index];
                var selected = unit == currentUnit;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    minVerticalPadding: 0,
                    selected: selected,
                    title: Text(
                        AppLocalizations.of(context)
                            .khatmaSplitUnit(currentUnit.name),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: selected
                                  ? Theme.of(context).primaryColor
                                  : null,
                            )),
                    subtitle: Text(
                      AppLocalizations.of(context)
                          .khatmaSplitUnitDesc(currentUnit.name),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Avatar(
                      radius: 30,
                      backgroundColor: selected
                          ? Theme.of(context).primaryColor.withOpacity(.15)
                          : Theme.of(context).disabledColor,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      bottom: selected
                          ? Avatar(
                              radius: 10,
                              child: RadioIcon(selected: selected, size: 18))
                          : null,
                      child: Icon(
                        unitIcons[currentUnit],
                        color: Theme.of(context).primaryColor,
                        size: 25,
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
      ),
    );
  }
}
// RadioIcon(selected: selected)