import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/extensions/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/num_dropdown_menu.dart';
import 'package:khatma/src/features/khatma/presentation/common/repeat_interval_menu.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/reccurence_text.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_provider.dart';

class OccurenceForm extends ConsumerWidget {
  const OccurenceForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(recurrenceNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH8,
        _buildRepeatInterval(context, ref),
        gapH12,
        _buildWeekDays(context, ref),
        gapH12,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RecurrenceText(updatedRecurrence),
        ),
      ],
    );
  }

  Row _buildRepeatInterval(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(recurrenceNotifierProvider);
    return Row(
      children: [
        gapW8,
        Text(AppLocalizations.of(context).repeatEvery.colon,
            style: Theme.of(context).textTheme.bodyLarge),
        gapW8,
        NumberDropdownMenu(
          enabled: updatedRecurrence.repeat &&
              updatedRecurrence.unit != RepeatInterval.auto,
          value: updatedRecurrence.frequency,
          onChanged: (value) {
            ref
                .read(recurrenceNotifierProvider.notifier)
                .update(updatedRecurrence.copyWith(frequency: value));
          },
        ),
        gapW8,
        RepeatIntervalDropdownMenu(
          enabled: updatedRecurrence.repeat,
          selectedUnit: updatedRecurrence.unit,
          onSelected: (value) {
            if (value == RepeatInterval.weekly &&
                ref.read(recurrenceNotifierProvider).daysOfWeek.isEmpty) {
              ref
                  .read(recurrenceNotifierProvider.notifier)
                  .update(updatedRecurrence.copyWith(unit: value!, days: [1]));
            } else {
              ref
                  .read(recurrenceNotifierProvider.notifier)
                  .update(updatedRecurrence.copyWith(unit: value!));
            }
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(recurrenceNotifierProvider);
    if (updatedRecurrence.unit != RepeatInterval.weekly ||
        !updatedRecurrence.repeat) {
      return const SizedBox.shrink();
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SizedBox(),
        /* WeekdaySelector(
          elevation: 2,
          firstDayOfWeek: 1,
          onChanged: (value) =>
              ref.read(recurrenceNotifierProvider.notifier).toggleDay(value),
          values: ref.read(recurrenceNotifierProvider).daysOfWeekSelected,
          selectedFillColor: Theme.of(context).primaryColor,
          selectedColor: Colors.white,
          weekdays: DayOfWeek.values
              .map((day) =>
                  AppLocalizations.of(context).weekDay(day.value.toString()))
              .toList(),
          shortWeekdays: DayOfWeek.values
              .map((day) => AppLocalizations.of(context)
                  .shortWeekDay(day.value.toString()))
              .toList(),
        ),*/
      ),
    );
  }
}
