import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/safe_text.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/themes/theme.dart';

class PartTileTitle extends StatelessWidget {
  const PartTileTitle({
    Key? key,
    required this.part,
    required this.isRead,
  }) : super(key: key);

  final Part part;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SafeText(
          part.title,
          maxLength: 20,
          style: isRead ? AppTheme.getTheme().textTheme.subtitle1 : null,
        ),
        SafeText(
          part.name,
          maxLength: 25,
          style: isRead ? AppTheme.getTheme().textTheme.subtitle1 : null,
        ),
      ],
    );
  }
}
