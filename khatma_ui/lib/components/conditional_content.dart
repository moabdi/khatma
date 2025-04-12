import 'package:flutter/material.dart';

class ConditionalContent extends StatelessWidget {
  const ConditionalContent({
    super.key,
    required this.condition,
    required this.primary,
    this.secondary,
  });

  final bool condition;
  final Widget primary;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    return condition ? primary : secondary ?? Container();
  }
}
