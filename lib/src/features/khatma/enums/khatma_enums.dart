enum KhatmaType { friday, monthly, ramadan, custom, mosque }

enum SplitUnit {
  sourat(114),
  hizb(60),
  juzz(30),
  rubue(240),
  thumun(480);

  final int value;
  const SplitUnit(this.value);
}
