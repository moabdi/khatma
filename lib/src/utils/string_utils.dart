extension SubstringExtension on String {
  reduce(int size) {
    if (runes.length >= size) {
      return "${substring(0, size)}...";
    }
    return this;
  }
}
