import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/cupertino.dart';

class ColorUtils {
  static Color shiftHsl(Color c, [double amt = 0]) {
    var hslc = HSLColor.fromColor(c);
    return hslc.withLightness((hslc.lightness + amt).clamp(0.0, 1.0)).toColor();
  }

  static Color parseHex(String value) =>
      Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  static Color blend(Color dst, Color src, double opacity) {
    return Color.fromARGB(
      255,
      (dst.r.toDouble() * (1.0 - opacity) + src.r.toDouble() * opacity).toInt(),
      (dst.g.toDouble() * (1.0 - opacity) + src.g.toDouble() * opacity).toInt(),
      (dst.b.toDouble() * (1.0 - opacity) + src.b.toDouble() * opacity).toInt(),
    );
  }

  static Color generateColorFromUUID(String uuid) {
    // Use SHA-256 to create a hash of the UUID
    final hash = sha256.convert(utf8.encode(uuid));
    final hashBytes = hash.bytes;

    // Take the first 3 bytes of the hash to create RGB values
    final r = hashBytes[0];
    final g = hashBytes[1];
    final b = hashBytes[2];

    // Create a color from the RGB values
    return Color.fromARGB(255, r, g, b);
  }
}
