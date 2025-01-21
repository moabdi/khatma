extension SubstringExtension on String {
  reduce(int size) {
    if (runes.length >= size) {
      return "${substring(0, size)}...";
    }
    return this;
  }

  bool get isArabic {
    var pattern = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');
    return pattern.hasMatch(this);
  }

  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get camelCase {
    return "${this[0].toLowerCase()}${substring(1)}";
  }

  String get colon => "$this:";
  String get spaceColon => "$this :";
}

bool isBlank(String? value) {
  return value == null || value.trim().isEmpty;
}
