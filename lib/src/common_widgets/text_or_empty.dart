import 'package:flutter/material.dart';

class TextOrEmpty extends StatelessWidget {
  const TextOrEmpty(this.text, {super.key, this.style});

  final String? text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return  text != null ? Text(text!, style: style,): const SizedBox(width: 0, height: 0,);
  }
}