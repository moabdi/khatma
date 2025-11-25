import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

class UnitSubtitle extends StatelessWidget {
  const UnitSubtitle({
    super.key,
    required this.unitNumber,
  });

  final int unitNumber;

  @override
  Widget build(BuildContext context) {
    final subtitleText = _getStartAyahForHizb(unitNumber);

    return Row(
      children: [
        Icon(
          Icons.menu_book_outlined,
          size: 12,
          color: context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          subtitleText,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getStartAyahForHizb(int hizbNumber) {
    final hizbData = {
      1: 'Al-Fatiha 1',
      2: 'Al-Baqarah 26',
      3: 'Al-Baqarah 60',
      4: 'Al-Baqarah 92',
      5: 'Al-Baqarah 124',
      6: 'Al-Baqarah 160',
      7: 'Al-Baqarah 177',
      8: 'Al-Baqarah 198',
    };
    return hizbData[hizbNumber] ?? 'Hizb $hizbNumber';
  }
}
