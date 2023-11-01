import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileLeading extends StatelessWidget {
  const PartTileLeading({
    super.key,
    required this.isRead,
    required this.isSelected,
    required this.part,
    required this.color,
  });

  final bool isRead;
  final bool isSelected;
  final Part part;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isRead
          ? AppTheme.getTheme().disabledColor
          : isSelected
              ? color
              : color.withOpacity(.1),
      child: Text(
        part.id.toString(),
        style: AppTheme.getTheme().textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : color,
            ),
      ),
    );
  }
}
