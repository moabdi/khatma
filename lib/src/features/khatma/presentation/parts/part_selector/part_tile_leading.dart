import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileLeading extends StatelessWidget {
  const PartTileLeading({
    super.key,
    required this.isRead,
    required this.isSelected,
    required this.part,
  });

  final bool isRead;
  final bool isSelected;
  final Part part;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isRead
          ? AppTheme.getTheme().disabledColor
          : isSelected
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().primaryColor.withOpacity(.1),
      child: Text(part.id.toString(),
          style: AppTheme.getTheme().textTheme.titleLarge!.copyWith(
              color: isRead
                  ? null
                  : isSelected
                      ? AppTheme.getTheme().backgroundColor
                      : AppTheme.getTheme().primaryColor)),
    );
  }
}
