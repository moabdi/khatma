import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

class FormKhatmaNotifier extends ChangeNotifier {
  Khatma _khatma;

  Khatma get khatma => _khatma;

  FormKhatmaNotifier(this._khatma);

  void update(Khatma updatedKhatma) {
    _khatma = updatedKhatma;
    notifyListeners();
  }

  void initialize() {
    _khatma = initKhatma();
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
    share: KhatmaShare(visibility: ShareVisibility.private),
    recurrence: Recurrence(
      repeat: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RepeatInterval.monthly,
      frequency: 1,
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

  void toggleDay(int day) {
    var days = List<int>.from(_recurrence.days ?? []);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    if (days.isEmpty) days.add(1);
    _recurrence = _recurrence.copyWith(days: days);
    notifyListeners();
  }
}

final formRecurrenceProvider =
    ChangeNotifierProvider<RecurrenceNotifier>((ref) {
  return RecurrenceNotifier(
    Recurrence(
      repeat: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RepeatInterval.auto,
      frequency: 1,
    ),
  );
});

class ShareNotifier extends ChangeNotifier {
  KhatmaShare _khatmaShare;

  KhatmaShare get khatmaShare => _khatmaShare;

  ShareNotifier(this._khatmaShare);

  void update(KhatmaShare khatmaShare) {
    _khatmaShare = khatmaShare;
    notifyListeners();
  }
}

final formShareProvider = ChangeNotifierProvider<ShareNotifier>((ref) {
  return ShareNotifier(
    const KhatmaShare(visibility: ShareVisibility.private),
  );
});
