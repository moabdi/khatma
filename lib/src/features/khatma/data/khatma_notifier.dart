import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

class KhatmaNotifier extends ChangeNotifier {
  Khatma _khatma;

  Khatma get khatma => _khatma;

  KhatmaNotifier(this._khatma);

  void updateKhatma(Khatma updatedKhatma) {
    _khatma = updatedKhatma;
    notifyListeners();
  }
}

final formKhatmaProvider = ChangeNotifierProvider<KhatmaNotifier>((ref) {
  return KhatmaNotifier(
    Khatma(
      name: 'test',
      unit: SplitUnit.hizb,
      createDate: DateTime.now(),
      share: ShareType.private,
      recurrence: Recurrence(
        scheduler: KhatmaScheduler.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        unit: RecurrenceUnit.once,
        occurrence: 1,
      ),
      style: KhatmaStyle(
        color: AppTheme.getTheme().primaryColor.toString(),
        icon: khatmaImagesMap.entries.first.key,
      ),
    ),
  );
});

class RecurrenceNotifier extends ChangeNotifier {
  Recurrence _recurrence;

  Recurrence get recurrence => _recurrence;

  RecurrenceNotifier(this._recurrence);

  void updateRecurrence(Recurrence updatedRecurrence) {
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
      unit: RecurrenceUnit.monthly,
      occurrence: 1,
    ),
  );
});
