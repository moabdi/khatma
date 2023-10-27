import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/safe_text.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileSubtitle extends StatelessWidget {
  const PartTileSubtitle({
    super.key,
    required this.part,
  });

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeText(
          part.subtitle,
          style: AppTheme.getTheme().textTheme.titleSmall,
        ),
        SafeText(
          part.subname,
          style: AppTheme.getTheme().textTheme.titleSmall,
        ),
      ],
    );
  }
}
