import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:khatma/src/themes/theme.dart';

LinkedHashMap<String, Color> khatmaColorMap =
    LinkedHashMap<String, Color>.from({
  Colors.black.toHex(): const Color.fromARGB(0, 155, 87, 87),
  AppTheme.getTheme().primaryColor.toHex(): AppTheme.getTheme().primaryColor,
  Colors.orange.toHex(): Colors.orange,
  Colors.red.toHex(): Colors.red,
  Colors.pink.toHex(): Colors.pink,
  Colors.purple.toHex(): Colors.purple,
  Colors.deepPurple.toHex(): Colors.deepPurple,
  Colors.indigo.toHex(): Colors.indigo,
  Colors.blue.toHex(): Colors.blue,
  Colors.lightBlue.toHex(): Colors.lightBlue,
  Colors.cyan.toHex(): Colors.cyan,
  Colors.teal.toHex(): Colors.teal,
  Colors.green.toHex(): Colors.green,
  Colors.blueGrey.toHex(): Colors.blueGrey,
});

List<String> khatmaColorHexList = khatmaColorMap.keys.toList();
