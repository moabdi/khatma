import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/day_of_week.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';
import 'package:khatma/src/common/widgets/date_picker_tile.dart';
import 'package:khatma/src/features/khatma/presentation/common/num_dropdown_menu.dart';
import 'package:khatma/src/features/khatma/presentation/common/repeat_interval_menu.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:weekday_selector/weekday_selector.dart';

class RecurrenceSelector extends ConsumerStatefulWidget {
  const RecurrenceSelector({
    super.key,
    required this.recurrence,
    required this.onSelect,
  });

  final Recurrence recurrence;
  final ValueChanged<Recurrence> onSelect;

  @override
  ConsumerState<RecurrenceSelector> createState() => _RecurrenceSelectorState();
}

class _RecurrenceSelectorState extends ConsumerState<RecurrenceSelector> {
  late RepeatInterval selectedCustomRecurrenceValue;

  @override
  Widget build(BuildContext context) {
    Recurrence updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              minVerticalPadding: 0,
              title: Text(AppLocalizations.of(context).repeat,
                  style: Theme.of(context).textTheme.bodyLarge),
              subtitle: Text(AppLocalizations.of(context).repeatDescription,
                  style: Theme.of(context).textTheme.bodyMedium),
              leading: Avatar(
                radius: 30,
                backgroundColor: Theme.of(context).disabledColor,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.autorenew,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
              ),
              trailing: Switch(
                  value: updatedRecurrence.repeat,
                  onChanged: (value) {
                    ref
                        .read(formRecurrenceProvider)
                        .update(updatedRecurrence.copyWith(repeat: value));
                  }),
            ),
          ),
          gapH12,
          Card(
            child: _buildForm(context),
          ),
          gapH12,
          Card(
            child: _recurrence(),
          ),
          gapH32,
          buildSave(),
          gapH12,
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    Recurrence updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return Column(
      children: [
        DatePickerListTile(
          enabled: updatedRecurrence.repeat,
          title: AppLocalizations.of(context).startDate,
          leading: Avatar(
            radius: 30,
            backgroundColor: Theme.of(context).disabledColor,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.today,
                size: 25, color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          value: updatedRecurrence.startDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .update(updatedRecurrence.copyWith(startDate: value)),
        ),
        const Divider(height: 0),
        DatePickerListTile(
          enabled: updatedRecurrence.repeat,
          title: AppLocalizations.of(context).endDate,
          leading: Avatar(
            radius: 30,
            backgroundColor: Theme.of(context).disabledColor,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.event_available,
                size: 25, color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          value: updatedRecurrence.endDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .update(updatedRecurrence.copyWith(endDate: value)),
        ),
      ],
    );
  }

  Widget _recurrence() {
    Recurrence updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH8,
        Row(
          children: [
            gapW8,
            Text(AppLocalizations.of(context).repeatEvery.withColon,
                style: Theme.of(context).textTheme.bodyMedium),
            gapW8,
            NumberDropdownMenu(
              enabled: updatedRecurrence.repeat,
              value: updatedRecurrence.frequency,
              onChanged: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .update(updatedRecurrence.copyWith(frequency: value));
              },
            ),
            gapW8,
            RepeatIntervalDropdownMenu(
              enabled: updatedRecurrence.repeat,
              selectedUnit: updatedRecurrence.unit,
              onSelected: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .update(updatedRecurrence.copyWith(unit: value!));
              },
            ),
          ],
        ),
        gapH12,
        if (updatedRecurrence.unit == RepeatInterval.weekly)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: WeekdaySelector(
                elevation: 2,
                firstDayOfWeek: 1,
                onChanged: (value) =>
                    ref.read(formRecurrenceProvider).toggleDay(value),
                values: ref
                    .read(formRecurrenceProvider)
                    .recurrence
                    .daysOfWeekSelected,
                selectedFillColor: Theme.of(context).primaryColor,
                selectedColor: Colors.white,
                weekdays: DayOfWeek.values
                    .map(
                        (day) => AppLocalizations.of(context).weekDay(day.name))
                    .toList(),
                shortWeekdays: DayOfWeek.values
                    .map((day) =>
                        AppLocalizations.of(context).shortWeekDay(day.name))
                    .toList(),
              ),
            ),
          ),
        gapH12,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "${AppLocalizations.of(context).repeatEvery} ${updatedRecurrence.frequency} ${AppLocalizations.of(context).timePeriods(updatedRecurrence.unit.name).toLowerCase()}",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }

  Container buildSave() {
    bool isChanged = ref.read(formKhatmaProvider).khatma.recurrence.hashCode !=
        ref.read(formRecurrenceProvider).recurrence.hashCode;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: isChanged
              ? () {
                  widget.onSelect(ref.read(formRecurrenceProvider).recurrence);
                  Navigator.pop(context);
                }
              : null,
          child: Text(AppLocalizations.of(context).apply)),
    );
  }
}
