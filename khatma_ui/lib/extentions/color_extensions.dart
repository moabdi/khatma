import 'dart:ui';

extension ColorExtension on Color {
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      a.toInt(),
      (r * value).round(),
      (g * value).round(),
      (b * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      a.toInt(),
      (r + ((255 - r) * value)).round(),
      (g + ((255 - g) * value)).round(),
      (b + ((255 - b) * value)).round(),
    );
  }

  Color avg(Color other) {
    final r = (this.r + other.r) ~/ 2;
    final g = (this.g + other.g) ~/ 2;
    final b = (this.b + other.b) ~/ 2;
    final a = (this.a + other.a) ~/ 2;
    return Color.fromARGB(a, r, g, b);
  }

  String toHex() =>
      '#${(toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  Color applyOpacity(double opacity) {
    assert(opacity >= 0 && opacity <= 1);
    return withValues(
      alpha: a * opacity,
      red: r,
      green: g,
      blue: b,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

extension StringToColor on String {
  Color toColor() => HexColor(this);
}
