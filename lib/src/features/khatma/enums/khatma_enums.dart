enum KhatmaType { friday, monthly, ramadan, custom, mosque }

enum SplitUnit {
  sourat(114),
  juzz(30),
  hizb(60),
  rubue(240),
  thumun(480);

  final int value;
  const SplitUnit(this.value);
}

enum KhatmaScheduler { never, done, custom }
