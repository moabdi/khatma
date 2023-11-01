import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.radius = 40,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(8),
    this.child,
    this.bottom,
    this.onTap,
  });

  final double radius;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final Avatar? bottom;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
