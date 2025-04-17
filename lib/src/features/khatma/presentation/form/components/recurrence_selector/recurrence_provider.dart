import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurrence_provider.g.dart';

@Riverpod(keepAlive: true)
class RecurrenceNotifier extends _$RecurrenceNotifier {
  Recurrence build() {
    return initRecurrence();
  }

  Recurrence initRecurrence() {
    return Recurrence(
      repeat: true,
      unit: RepeatInterval.auto,
    );
  }

  void update(Recurrence? updatedRecurrence) {
    state = updatedRecurrence ?? initRecurrence();
  }

  void toggleDay(int day) {
    var days = List<int>.from(state.days ?? []);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    if (days.isEmpty) days.add(1);
    state = state.copyWith(days: days);
  }
}
