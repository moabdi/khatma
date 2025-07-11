import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double radius;
  final String? heroTag;
  final double scale; // Scale factor for zooming
  final BoxFit fit; // How the image should fit

  const AppLogo({
    super.key,
    this.radius = 50,
    this.heroTag = 'app_logo',
    this.scale = 1, // Default zoom out to 80%
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: radius,
      child: Image.asset(
        'assets/khatma.png',
        width: radius * 2.1,
        height: radius * 2.1,
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: logoWidget,
      );
    }

    return logoWidget;
  }
}
