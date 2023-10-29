import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class UnitSelector extends StatelessWidget {
  const UnitSelector({super.key, required this.unit, required this.onSelect});
  final SplitUnit unit;
  final ValueChanged<SplitUnit> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            padding: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.getTheme().dividerColor,
                  width: 3.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(AppLocalizations.of(context).splitUnit,
              style: AppTheme.getTheme().textTheme.titleLarge),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: SplitUnit.values.length,
          itemBuilder: (BuildContext context, int index) {
            var currentUnit = SplitUnit.values[index];
            var selected = unit == currentUnit;
            return ListTile(
              tileColor: selected
                  ? AppTheme.getTheme().primaryColor.withOpacity(.1)
                  : null,
              title: Text(AppLocalizations.of(context)
                  .khatmaSplitUnit(currentUnit.name)),
              subtitle: Text(AppLocalizations.of(context)
                  .khatmaSplitUnitDesc(currentUnit.name)),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  size: 32,
                  color: selected
                      ? AppTheme.getTheme().primaryColor
                      : AppTheme.getTheme().dividerColor,
                ),
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
