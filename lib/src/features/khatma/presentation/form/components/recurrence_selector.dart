import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_unit_menu.dart';
import 'package:khatma/src/common/widgets/number_menu.dart';
import 'package:khatma/src/common/widgets/date_picker_label.dart';
import 'package:khatma/src/common/widgets/date_picker_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_tile.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/themes/theme.dart';

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
  late RecurrenceUnit selectedCustomRecurrenceValue;

  final TextEditingController _frequencyEditingController =
      TextEditingController();
  final TextEditingController unitController = TextEditingController();

  late Recurrence updatedRecurrence;
  late int oldRecurrenceHash;

  Map<KhatmaScheduler, Widget> schedulerIcons = {
    KhatmaScheduler.never: const Icon(Icons.block, color: Colors.grey),
    KhatmaScheduler.autoRepeat: const Icon(Icons.autorenew, color: Colors.blue),
    KhatmaScheduler.custom:
        const Icon(Icons.history_toggle_off_sharp, color: Colors.orange),
  };

  @override
  void initState() {
    super.initState();
    selectedCustomRecurrenceValue =
        widget.recurrence.unit ?? RecurrenceUnit.month;
    _frequencyEditingController.text = widget.recurrence.occurrence.toString();
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildListView(),
        gapH12,
        AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildForm(),
          ),
        ),
        const Divider(height: 1),
        gapH12,
        buildSave(),
        gapH32,
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemCount: KhatmaScheduler.values.length,
      itemBuilder: (context, index) {
        KhatmaScheduler scheduler = KhatmaScheduler.values[index];
        return Column(
          children: [
            RecurrenceTile(
              value: scheduler,
              icon: schedulerIcons[scheduler]!,
              selectedValue: updatedRecurrence.scheduler,
              onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
                    updatedRecurrence.copyWith(scheduler: scheduler),
                  ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildForm() {
    if (KhatmaScheduler.never == updatedRecurrence.scheduler) {
      return const SizedBox();
    }
    return Column(
      children: [
        gapH12,
        DatePickerListTile(
          title: AppLocalizations.of(context).startDate,
          leading: const Icon(Icons.today),
          value: updatedRecurrence.startDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .updateRecurrence(updatedRecurrence.copyWith(startDate: value)),
        ),
        gapH12,
        DatePickerListTile(
          title: AppLocalizations.of(context).endDate,
          leading: const Icon(Icons.event_available),
          value: updatedRecurrence.endDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .updateRecurrence(updatedRecurrence.copyWith(endDate: value)),
        ),
        gapH12,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).disabledColor,
          ),
          padding: EdgeInsets.all(5),
          child: _recurrence(),
        ),
        gapH12,
      ],
    );
  }

  Widget _recurrence() {
    if (updatedRecurrence.scheduler != KhatmaScheduler.custom) {
      return const SizedBox();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).repeatEvery.withColon,
          style: AppTheme.getTheme().textTheme.labelMedium,
        ),
        gapW12,
        Flexible(
          child: NumberDropdownMenu(
              initialValue:
                  ref.read(formRecurrenceProvider).recurrence.occurrence,
              onSelected: (value) {
                ref.read(formRecurrenceProvider).updateRecurrence(
                    updatedRecurrence.copyWith(occurrence: value));
              }),
        ),
        gapW12,
        Flexible(
          child: UnitDropdownMenu(
              selectedUnit: ref.read(formRecurrenceProvider).recurrence.unit,
              onSelected: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .updateRecurrence(updatedRecurrence.copyWith(unit: value));
              }),
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
