import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

LinkedHashMap<String, Color> khatmaColorMap =
    LinkedHashMap<String, Color>.from({
  AppTheme.getTheme().primaryColor.toHex(): AppTheme.getTheme().primaryColor,
  Colors.deepPurple.toHex(): Colors.deepPurple,
  Colors.blue.toHex(): Colors.blue,
  Colors.deepOrange.toHex(): Colors.deepOrange,
  Colors.pink.toHex(): Colors.pink,
  Colors.brown.toHex(): Colors.brown,
});

List<String> khatmaColorHexList = khatmaColorMap.keys.toList();

extension ColorExtension on KhatmaTheme {
  Color get hexColor => HexColor(color);
}
