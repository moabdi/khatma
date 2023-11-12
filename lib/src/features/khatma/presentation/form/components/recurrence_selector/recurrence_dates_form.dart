import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/widgets/date_picker_tile.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RecurrenceDatePicker extends ConsumerWidget {
  const RecurrenceDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(formRecurrenceProvider).recurrence;
    return Column(
      children: [
        _buildStartDate(updatedRecurrence, context, ref),
        const Divider(height: 0),
        _buildEndDate(updatedRecurrence, context, ref),
      ],
    );
  }

  DatePickerListTile _buildStartDate(
      Recurrence updatedRecurrence, BuildContext context, WidgetRef ref) {
    return DatePickerListTile(
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
      onChanged: (value) => {
        ref
            .read(formRecurrenceProvider)
            .update(updatedRecurrence.copyWith(startDate: value)),
        if (ref.read(formRecurrenceProvider).recurrence.endDate.isBefore(value))
          {
            ref.read(formRecurrenceProvider).update(updatedRecurrence.copyWith(
                endDate: value.add(const Duration(days: 366))))
          },
      },
    );
  }

  DatePickerListTile _buildEndDate(
      Recurrence updatedRecurrence, BuildContext context, WidgetRef ref) {
    return DatePickerListTile(
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
      firstDate: updatedRecurrence.startDate,
      onChanged: (value) => ref
          .read(formRecurrenceProvider)
          .update(updatedRecurrence.copyWith(endDate: value)),
    );
  }
}
