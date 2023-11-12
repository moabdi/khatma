import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/features/khatma/data/khatma_form_notifier.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/occurence_form.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_dates_form.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/repeat_enabler_tile.dart';

class RecurrenceSelector extends ConsumerWidget {
  const RecurrenceSelector({
    super.key,
    required this.recurrence,
    required this.onChanged,
  });

  final Recurrence recurrence;
  final ValueChanged<Recurrence> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isChanged = ref.read(formKhatmaProvider).khatma.recurrence.hashCode !=
        ref.read(formRecurrenceProvider).recurrence.hashCode;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Card(child: RepeatEnablerTile()),
          gapH12,
          const Card(child: RecurrenceDatePicker()),
          gapH12,
          const Card(child: OccurenceForm()),
          gapH32,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: isChanged
                    ? () {
                        onChanged(ref.read(formRecurrenceProvider).recurrence);
                        Navigator.pop(context);
                      }
                    : null,
                child: Text(AppLocalizations.of(context).apply)),
          ),
          gapH12,
        ],
      ),
    );
  }
}
