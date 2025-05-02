import 'package:flutter/material.dart';

class AdjustNumberButton extends StatelessWidget {
  const AdjustNumberButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = 18,
    this.iconColor,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      child: IconButton(
        iconSize: iconSize,
        color: iconColor ?? Colors.black,
        padding: const EdgeInsetsDirectional.all(0),
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
