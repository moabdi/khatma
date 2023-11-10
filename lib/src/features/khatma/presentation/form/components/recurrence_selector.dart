import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/day_of_week.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/num_dropdown_menu.dart';
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

  final TextEditingController _frequencyEditingController =
      TextEditingController();
  final TextEditingController unitController = TextEditingController();

  late Recurrence updatedRecurrence;
  late int oldRecurrenceHash;

  @override
  void initState() {
    super.initState();
    selectedCustomRecurrenceValue = widget.recurrence.unit;
    _frequencyEditingController.text = widget.recurrence.frequency.toString();
    oldRecurrenceHash = widget.recurrence.hashCode;
  }

  @override
  void dispose() {
    _frequencyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(0),
                minVerticalPadding: 0,
                title: Text("Repeat",
                    style: Theme.of(context).textTheme.bodyLarge),
                subtitle: Text("Enable recreate khatma",
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
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
            ),
          ),
          gapH12,
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: AnimatedSize(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 600),
                child: _buildForm(context),
              ),
            ),
          ),
          gapH12,
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: _recurrence(),
            ),
          ),
          gapH32,
          buildSave(),
          gapH12,
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        DatePickerListTile(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH8,
        Row(
          children: [
            gapW8,
            Text("Recurrence:", style: Theme.of(context).textTheme.bodyMedium),
            gapW16,
            Row(
              children: [
                RepeatIntervalDropdownMenu(
                  selectedUnit:
                      ref.read(formRecurrenceProvider).recurrence.unit,
                  onSelected: (value) {
                    ref
                        .read(formRecurrenceProvider)
                        .update(updatedRecurrence.copyWith(unit: value!));
                  },
                ),
              ],
            ),
          ],
        ),
        gapH12,
        Row(
          children: [
            gapW8,
            Text("Repeat evry:", style: Theme.of(context).textTheme.bodyMedium),
            gapW8,
            NumberDropdownMenu(
              value: ref.read(formRecurrenceProvider).recurrence.frequency,
              onChanged: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .update(updatedRecurrence.copyWith(frequency: value));
              },
            ),
            gapW8,
            Text("${ref.read(formRecurrenceProvider).recurrence.unit.name}",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        gapH12,
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
                  .map((day) => AppLocalizations.of(context).weekDay(day.name))
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
              "Repeat  evry ${ref.read(formRecurrenceProvider).recurrence.frequency} ${ref.read(formRecurrenceProvider).recurrence.unit.name}",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }

  Container buildSave() {
    bool isChanged = oldRecurrenceHash !=
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
