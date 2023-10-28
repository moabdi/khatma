import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

class RecurrenceTile extends StatelessWidget {
  const RecurrenceTile(
      {super.key,
      required this.value,
      this.subtitle,
      required this.icon,
      required this.selectedValue,
      required this.onTap});

  final KhatmaScheduler value;
  final String? subtitle;
  final Widget icon;
  final KhatmaScheduler selectedValue;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedValue == value;

    return ListTile(
        tileColor: isSelected
            ? AppTheme.getTheme().primaryColor.withOpacity(.1)
            : null,
        title: Text(value.name),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        leading: icon,
        onTap: onTap,
        trailing: isSelected
            ? Icon(
                Icons.check,
                color: AppTheme.getTheme().primaryColor,
              )
            : null);
  }
}
