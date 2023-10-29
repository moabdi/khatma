import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_unit_menu.dart';
import 'package:khatma/src/features/khatma/presentation/common/number_menu.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/date_picker_label.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/top_bar_bottom_sheet.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBarBottomSheet(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            AppLocalizations.of(context).recurrence.withColon,
            style: AppTheme.getTheme().textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 0),
            shrinkWrap: true,
            itemCount: KhatmaScheduler.values.length,
            itemBuilder: (context, index) {
              KhatmaScheduler scheduler = KhatmaScheduler.values[index];
              return Column(
                children: [
                  RecurrenceTile(
                    value: scheduler,
                    icon: schedulerIcons[scheduler]!,
                    selectedValue: updatedRecurrence.scheduler,
                    onTap: () =>
                        ref.read(formRecurrenceProvider).updateRecurrence(
                              updatedRecurrence.copyWith(scheduler: scheduler),
                            ),
                  ),
                ],
              );
            },
          ),
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
          label: AppLocalizations.of(context).startDate.withColon,
          dateTime: updatedRecurrence.startDate,
          onChanged: (value) => ref
              .read(formRecurrenceProvider)
              .updateRecurrence(
                  updatedRecurrence.copyWith(startDate: parse(value))),
        ),
        DateField(
          label: AppLocalizations.of(context).endDate.withColon,
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
            AppLocalizations.of(context).repeatEvery.withColon,
            style: AppTheme.getTheme().textTheme.titleSmall,
          ),
          gapW20,
          NumberDropdownMenu(
              selectedUnit:
                  ref.read(formRecurrenceProvider).recurrence.occurrence,
              onSelected: (value) {
                ref.read(formRecurrenceProvider).updateRecurrence(
                    updatedRecurrence.copyWith(occurrence: value));
              }),
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
                    widget
                        .onSelect(ref.read(formRecurrenceProvider).recurrence);
                    Navigator.pop(context);
                  }
                : null,
            child: Text(AppLocalizations.of(context).apply)),
      ),
    );
  }
}
