extension SubstringExtension on String {
  reduce(int size) {
    if (runes.length >= size) {
      return "${substring(0, size)}...";
    }
    return this;
  }

  bool isArabic() {
    var pattern = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');
    return pattern.hasMatch(this);
}
}
