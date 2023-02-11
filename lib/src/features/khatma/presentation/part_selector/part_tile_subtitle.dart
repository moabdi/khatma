import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/safe_text.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileSubtitle extends StatelessWidget {
  const PartTileSubtitle({
    Key? key,
    required this.part,
  }) : super(key: key);

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeText(
          part.subtitle,
          style: AppTheme.getTheme().textTheme.subtitle2,
        ),
        SafeText(
          part.subname,
          style: AppTheme.getTheme().textTheme.subtitle2,
        ),
      ],
    );
  }
}
