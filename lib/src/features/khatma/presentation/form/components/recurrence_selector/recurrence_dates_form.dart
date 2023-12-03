import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/widgets/date_picker_tile.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_controller.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_provider.dart';

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
    return DatePickerListTile(
      enabled: updatedRecurrence.repeat,
      title: AppLocalizations.of(context).startDate,
      leading: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.today),
      ),
      value: updatedRecurrence.startDate,
      onChanged: (value) => ref
          .read(recurrenceControllerProvider.notifier)
          .updateStartDate(value),
    );
  }

  DatePickerListTile _buildEndDate(
      Recurrence updatedRecurrence, BuildContext context, WidgetRef ref) {
    return DatePickerListTile(
      enabled: updatedRecurrence.repeat,
      title: AppLocalizations.of(context).endDate,
      leading: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.event_available),
      ),
      value: updatedRecurrence.endDate,
      firstDate: updatedRecurrence.startDate,
      onChanged: (value) => ref
          .read(recurrenceNotifierProvider.notifier)
          .update(updatedRecurrence.copyWith(endDate: value)),
    );
  }
}
