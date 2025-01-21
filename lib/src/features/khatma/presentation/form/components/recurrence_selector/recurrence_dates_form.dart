import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma_ui/components/input/date_picker_tile.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import './recurrence_controller.dart';
import './recurrence_provider.dart';

class RecurrenceDatePicker extends ConsumerWidget {
  const RecurrenceDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recurrence updatedRecurrence = ref.watch(recurrenceNotifierProvider);
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
    var onChanged = (value) =>
        ref.read(recurrenceControllerProvider.notifier).updateStartDate(value);

    return DatePickerListTile(
      enabled: updatedRecurrence.repeat,
      title: AppLocalizations.of(context).startDate,
      leading: IconButton(
        padding: const EdgeInsets.all(10),
        icon: const Icon(Icons.today),
        onPressed: updatedRecurrence.repeat ? () {} : null,
      ),
      value: updatedRecurrence.startDate,
      onChanged: onChanged,
    );
  }

  DatePickerListTile _buildEndDate(
      Recurrence updatedRecurrence, BuildContext context, WidgetRef ref) {
    return DatePickerListTile(
      enabled: updatedRecurrence.repeat,
      title: AppLocalizations.of(context).endDate,
      leading: IconButton(
        padding: const EdgeInsets.all(10),
        icon: const Icon(Icons.event_available),
        onPressed: updatedRecurrence.repeat ? () {} : null,
      ),
      value: updatedRecurrence.endDate,
      firstDate: updatedRecurrence.startDate,
      onChanged: (value) => ref
          .read(recurrenceNotifierProvider.notifier)
          .update(updatedRecurrence.copyWith(endDate: value)),
    );
  }
}
