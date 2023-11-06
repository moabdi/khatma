import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

class FormKhatmaNotifier extends ChangeNotifier {
  Khatma _khatma;
  Khatma _origin;

  Khatma get khatma => _khatma;

  FormKhatmaNotifier(this._khatma) : _origin = _khatma.copyWith();

  void update(Khatma updatedKhatma) {
    _khatma = updatedKhatma;
    notifyListeners();
  }

  void reset() {
    _khatma = _origin.copyWith();
    notifyListeners();
  }

  void init(Khatma khatma) {
    _khatma = khatma;
    _origin = khatma.copyWith();
  }
}

final formKhatmaProvider = ChangeNotifierProvider<FormKhatmaNotifier>((ref) {
  return FormKhatmaNotifier(initKhatma());
});

Khatma initKhatma() {
  return Khatma(
    name: '',
    unit: SplitUnit.hizb,
    createDate: DateTime.now(),
    share: KhatmaShareType.private,
    recurrence: Recurrence(
      scheduler: KhatmaScheduler.never,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RecurrenceUnit.month,
      occurrence: 1,
    ),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toHex(),
      icon: khatmaImagesMap.entries.first.key,
    ),
  );
}

class RecurrenceNotifier extends ChangeNotifier {
  Recurrence _recurrence;

  Recurrence get recurrence => _recurrence;

  RecurrenceNotifier(this._recurrence);

  void update(Recurrence updatedRecurrence) {
    _recurrence = updatedRecurrence;
    notifyListeners();
  }
}

final formRecurrenceProvider =
    ChangeNotifierProvider<RecurrenceNotifier>((ref) {
  return RecurrenceNotifier(
    Recurrence(
      scheduler: KhatmaScheduler.never,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RecurrenceUnit.month,
      occurrence: 1,
    ),
  );
});
