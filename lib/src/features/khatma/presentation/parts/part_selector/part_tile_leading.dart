import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileLeading extends StatelessWidget {
  const PartTileLeading({
    super.key,
    required this.enabled,
    required this.selected,
    required this.part,
    required this.color,
  });

  final bool enabled;
  final bool selected;
  final Part part;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: enabled
          ? selected
              ? color
              : color.withOpacity(.1)
          : AppTheme.getTheme().disabledColor,
      child: Text(
        part.id.toString(),
        style: AppTheme.getTheme().textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : color,
            ),
      ),
    );
  }
}
