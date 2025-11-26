import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitAvatar extends StatelessWidget {
  const UnitAvatar({
    super.key,
    required this.unitNumber,
    required this.backgroundColor,
    required this.borderColor,
    required this.numberColor,
    this.isSelected = false,
  });

  final int unitNumber;
  final Color backgroundColor;
  final Color borderColor;
  final Color numberColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? context.colorScheme.primary : backgroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isSelected
              ? context.colorScheme.primary
              : borderColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: isSelected
            ? Icon(
                Icons.check,
                size: 24,
                color: context.colorScheme.onPrimary,
              )
            : Text(
                '$unitNumber',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
              ),
      ),
    );
  }
}
