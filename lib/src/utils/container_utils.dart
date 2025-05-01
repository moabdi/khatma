import 'package:flutter/material.dart';

class ShapeBorderBuilder {
  static ShapeBorder topRoundedBorder({double radius = 15}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

  static ShapeBorder bottomRoundedBorder({double radius = 15}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
    );
  }
}
