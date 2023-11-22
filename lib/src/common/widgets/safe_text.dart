import 'package:flutter/material.dart';
import 'package:khatma/src/common/extensions/string_extention.dart';

class SafeText extends StatelessWidget {
  const SafeText(
    this.text, {
    super.key,
    this.maxLength,
    this.style,
  });

  final String text;
  final int? maxLength;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var value = maxLength == null || maxLength == 0 || maxLength! >= text.length
        ? text
        : text.isArabic()
            ? "...${text.substring(0, maxLength)}"
            : "${text.substring(0, maxLength)}...";
    return Text(
      value,
      style: style,
    );
  }
}
