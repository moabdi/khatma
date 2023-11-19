import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:flutter/material.dart';

class KhatmaNotifier extends ChangeNotifier {
  Khatma _khatma;

  Khatma get khatma => _khatma;

  KhatmaNotifier(this._khatma);

  Future<void> withKhatma(Khatma khatma) async {
    _khatma = khatma;
  }

  void update(Khatma khatma) {
    _khatma = khatma;
    notifyListeners();
  }
}

final khatmaDetailsProvider = ChangeNotifierProvider<KhatmaNotifier>((ref) {
  return KhatmaNotifier(initKhatma());
});

Khatma initKhatma() {
  return Khatma(
    name: '',
    unit: SplitUnit.hizb,
    createDate: DateTime.now(),
    share: KhatmaShare(visibility: ShareVisibility.private),
    recurrence: Recurrence(
      repeat: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RepeatInterval.monthly,
      frequency: 0,
    ),
    style: const KhatmaStyle(
      color: '',
      icon: '',
    ),
  );
}
