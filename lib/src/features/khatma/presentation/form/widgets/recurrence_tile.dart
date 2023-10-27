import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

class RecurrenceTile extends StatelessWidget {
  const RecurrenceTile(
      {super.key,
      required this.value,
      required this.selectedValue,
      required this.onTap});

  final KhatmaScheduler value;
  final KhatmaScheduler selectedValue;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedValue == value;
    final Color iconColor = isSelected
        ? AppTheme.getTheme().primaryColor
        : AppTheme.getTheme().dividerColor;

    return ListTile(
      tileColor:
          isSelected ? AppTheme.getTheme().primaryColor.withOpacity(.1) : null,
      title: Text(value.name),
      subtitle: const Text("title"),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
          size: 32,
          color: iconColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
