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
}
