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
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: borderColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              '$unitNumber',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: numberColor,
              ),
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.check,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
