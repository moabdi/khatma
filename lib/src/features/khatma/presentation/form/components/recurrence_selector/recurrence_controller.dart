import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'recurrence_controller.g.dart';

@riverpod
class RecurrenceController extends _$RecurrenceController {
  @override
  void build() {}
  void updateStartDate(DateTime value) {
    Recurrence recurrence = ref.read(recurrenceNotifierProvider);
    ref
        .read(recurrenceNotifierProvider.notifier)
        .update(recurrence.copyWith(startDate: value));
    var endDate = ref.read(recurrenceNotifierProvider).endDate;
    if (endDate == null || endDate.isBefore(value)) {
      ref.read(recurrenceNotifierProvider.notifier).update(
          recurrence.copyWith(endDate: value.add(const Duration(days: 366))));
    }
    ;
  }
}
