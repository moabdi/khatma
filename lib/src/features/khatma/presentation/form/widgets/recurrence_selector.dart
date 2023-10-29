import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/date_formatter.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_unit_menu.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/date_picker_label.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
import 'package:khatma/src/localization/i10n_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

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

  @override
  void initState() {
    super.initState();
    selectedCustomRecurrenceValue =
        widget.recurrence.unit ?? RecurrenceUnit.monthly;
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBarBottomSheet(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            AppLocalizations.of(context).recurrence,
            style: AppTheme.getTheme().textTheme.titleLarge,
          ),
        ),
        RecurrenceTile(
          value: KhatmaScheduler.never,
          icon: Icon(Icons.block, color: Colors.grey),
          selectedValue: updatedRecurrence.scheduler,
          onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
                updatedRecurrence.copyWith(scheduler: KhatmaScheduler.never),
              ),
        ),
        const Divider(height: 0),
        RecurrenceTile(
          value: KhatmaScheduler.autoRepeat,
          icon: Icon(Icons.autorenew, color: Colors.blue),
          selectedValue: updatedRecurrence.scheduler,
          onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
              updatedRecurrence.copyWith(
                  scheduler: KhatmaScheduler.autoRepeat)),
        ),
        const Divider(height: 0),
        RecurrenceTile(
          value: KhatmaScheduler.custom,
          icon: Icon(Icons.history_toggle_off_sharp, color: Colors.orange),
          selectedValue: updatedRecurrence.scheduler,
          onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
              updatedRecurrence.copyWith(scheduler: KhatmaScheduler.custom)),
        ),
        AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 600),
          child: _buildForm(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(indent: 1),
        ),
        buildSave(),
        gapH32,
      ],
    );
  }

  Widget _buildForm() {
    if (KhatmaScheduler.never == updatedRecurrence.scheduler) {
      return const SizedBox();
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(indent: 0.2),
        ),
        DateField(
          label: "Start date:",
          dateTime: updatedRecurrence.startDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .updateRecurrence(
                  updatedRecurrence.copyWith(startDate: parse(value))),
        ),
        DateField(
          label: "End date:",
          dateTime: updatedRecurrence.endDate,
          onChanged: (value) => {
            ref.read(formRecurrenceProvider).updateRecurrence(
                updatedRecurrence.copyWith(endDate: parse(value)))
          },
        ),
        _recurrence(),
      ],
    );
  }

  Widget _recurrence() {
    if (updatedRecurrence.scheduler != KhatmaScheduler.custom) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Every:",
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapW20,
          SizedBox(
            width: 55,
            child: TextField(
              maxLength: 2,
              controller: _frequencyEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                counterText: "",
              ),
              onChanged: (value) {
                ref.read(formRecurrenceProvider).updateRecurrence(
                    updatedRecurrence.copyWith(occurrence: int.parse(value)));
              },
            ),
          ),
          gapW20,
          UnitDropdownMenu(
              selectedUnit: ref.read(formRecurrenceProvider).recurrence.unit,
              onSelected: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .updateRecurrence(updatedRecurrence.copyWith(unit: value));
              }),
        ],
      ),
    );
  }

  Container buildSave() {
    bool isChanged = oldRecurrenceHash !=
        ref.read(formRecurrenceProvider).recurrence.hashCode;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: isChanged
              ? () {
                  widget.onSelect(ref.read(formRecurrenceProvider).recurrence);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Apply'),
        ),
      ),
    );
  }
}
