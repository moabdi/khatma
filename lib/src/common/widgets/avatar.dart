import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.radius = 40,
    this.width = 50,
    this.height = 50,
    this.backgroundColor = Colors.transparent,
    this.child,
    this.bottom,
    this.onTap,
  });

  final double radius;
  final double width;
  final double height;
  final Widget? child;
  final Color backgroundColor;
  final Avatar? bottom;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: FittedBox(child: child),
                ),
              ),
              if (bottom != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: bottom!.radius != radius ? bottom!.radius : 10,
                    backgroundColor: bottom!.backgroundColor,
                    child: bottom!.child,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
