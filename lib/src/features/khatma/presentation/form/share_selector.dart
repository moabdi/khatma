import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class ShareSelector extends StatelessWidget {
  const ShareSelector(
      {super.key, this.unit = ShareType.individual, required this.onSelect});
  final ShareType unit;
  final ValueChanged<ShareType> onSelect;

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
          child:
              Text("Share :", style: AppTheme.getTheme().textTheme.titleLarge),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: ShareType.values.length,
          itemBuilder: (BuildContext context, int index) {
            var currentUnit = ShareType.values[index];
            var selected = unit == currentUnit;
            return ListTile(
              dense: true,
              tileColor: selected
                  ? AppTheme.getTheme().primaryColor.withOpacity(.1)
                  : null,
              title: Text(currentUnit.name.capitalize()),
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
