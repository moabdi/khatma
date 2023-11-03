import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/radio_icon.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key, required this.unit, required this.onSelect});
  final SplitUnit unit;
  final ValueChanged<SplitUnit> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: SplitUnit.values.length,
          itemBuilder: (BuildContext context, int index) {
            var currentUnit = SplitUnit.values[index];
            var selected = unit == currentUnit;
            return ListTile(
              selected: selected,
              title: Text(AppLocalizations.of(context)
                  .khatmaSplitUnit(currentUnit.name)),
              subtitle: Text(AppLocalizations.of(context)
                  .khatmaSplitUnitDesc(currentUnit.name)),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RadioIcon(selected: selected),
              ),
              onTap: () {
                Navigator.pop(context);
                onSelect(currentUnit);
              },
            );
          },
        ),
        gapH20,
      ],
    );
  }
}
