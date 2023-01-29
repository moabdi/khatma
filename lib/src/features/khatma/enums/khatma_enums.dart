
enum KhatmaType { friday, monthly, ramadan, custom, mosque }
enum SplitUnit { sourat(114), hizb(60), juzz(30), quart(240), roubaa(480);
  final int value;
  const SplitUnit(this.value);
 }