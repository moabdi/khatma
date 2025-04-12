import 'package:flutter/material.dart';

class OptionalText extends StatelessWidget {
  const OptionalText(this.text, {super.key, this.style});

  final String? text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text?.isNotEmpty ?? false,
      child: Text(text!, style: style),
    );
  }
}
