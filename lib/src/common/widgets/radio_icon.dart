import 'package:flutter/material.dart';

class RadioIcon extends StatelessWidget {
  const RadioIcon({
    super.key,
    required this.selected,
  });

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Icon(
      selected ? Icons.check_circle_rounded : Icons.circle_outlined,
      color: selected
          ? Theme.of(context).primaryColor
          : Theme.of(context).dividerColor,
    );
  }
}
