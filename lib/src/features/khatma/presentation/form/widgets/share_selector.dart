import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class ShareSelector extends StatelessWidget {
  const ShareSelector(
      {super.key, this.unit = ShareType.private, required this.onSelect});
  final ShareType unit;
  final ValueChanged<ShareType> onSelect;

  @override
  Widget build(BuildContext context) {
    List<String> descriptions = [
      "The khatma will be kept private and exclusive to the organizer",
      "Everyone is welcome to access and join the khatma",
      "The khatma will be shared only with those who receive a specific number or QR code",
    ];

    List<Icon> icons = [
      Icon(FontAwesomeIcons.lock, color: Colors.orange),
      Icon(Icons.public, color: Colors.blue),
      Icon(Icons.group, color: Colors.purple),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBarBottomSheet(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child:
              Text("Share :", style: AppTheme.getTheme().textTheme.titleLarge),
        ),
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 0,
          ),
          shrinkWrap: true,
          itemCount: ShareType.values.length,
          itemBuilder: (BuildContext context, int index) {
            var currentUnit = ShareType.values[index];
            var selected = unit == currentUnit;
            return ListTile(
                tileColor: selected
                    ? AppTheme.getTheme().primaryColor.withOpacity(.1)
                    : null,
                title: Text(currentUnit.name.capitalize()),
                subtitle: Text(descriptions[index]),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: icons[index],
                ),
                onTap: () {
                  Navigator.pop(context);
                  onSelect(currentUnit);
                },
                trailing: selected
                    ? Icon(
                        Icons.check,
                        color: AppTheme.getTheme().primaryColor,
                      )
                    : null);
          },
        ),
        gapH20,
      ],
    );
  }
}
