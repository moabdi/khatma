import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurrence_provider.g.dart';

@riverpod
class RecurrenceNotifier extends _$RecurrenceNotifier {
  Recurrence build() {
    return Recurrence(
      repeat: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      unit: RepeatInterval.auto,
      frequency: 1,
    );
  }

  void update(Recurrence updatedRecurrence) {
    state = updatedRecurrence;
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
