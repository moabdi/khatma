import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/date_formatter.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/date_picker_label.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_tile.dart';
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

  late Recurrence updatedRecurrence;

  @override
  void initState() {
    super.initState();
    selectedCustomRecurrenceValue =
        widget.recurrence.unit ?? RecurrenceUnit.monthly;
    _frequencyEditingController.text = widget.recurrence.occurrence.toString();
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
        buildTopBar(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Set recurrence:",
            style: AppTheme.getTheme().textTheme.titleLarge,
          ),
        ),
        RecurrenceTile(
          value: KhatmaScheduler.never,
          selectedValue: updatedRecurrence.scheduler,
          onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
                updatedRecurrence.copyWith(scheduler: KhatmaScheduler.never),
              ),
        ),
        RecurrenceTile(
          value: KhatmaScheduler.autoRepeat,
          selectedValue: updatedRecurrence.scheduler,
          onTap: () => ref.read(formRecurrenceProvider).updateRecurrence(
              updatedRecurrence.copyWith(
                  scheduler: KhatmaScheduler.autoRepeat)),
        ),
        RecurrenceTile(
          value: KhatmaScheduler.custom,
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

  Stack buildTopBar(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Center(
          child: Container(
            width: 40,
            padding: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.getTheme().dividerColor,
                  width: 3.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            child: Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: AppTheme.getTheme().disabledColor,
              ),
              child: Icon(Icons.close, size: 18, color: Colors.blueGrey),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return KhatmaScheduler.never == updatedRecurrence.scheduler
        ? SizedBox()
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(indent: 0.2),
              ),
              DateField(
                context: context,
                label: "Start date:",
                dateTime: updatedRecurrence.startDate,
                onChanged: (value) => ref
                    .read(formRecurrenceProvider)
                    .updateRecurrence(
                        updatedRecurrence.copyWith(startDate: parse(value))),
              ),
              DateField(
                context: context,
                label: "End date:",
                dateTime: updatedRecurrence.endDate,
                onChanged: (value) => ref
                    .read(formRecurrenceProvider)
                    .updateRecurrence(
                        updatedRecurrence.copyWith(endDate: parse(value))),
              ),
              _recurrence(),
            ],
          );
  }

  Widget _recurrence() {
    if (updatedRecurrence.scheduler != KhatmaScheduler.custom) {
      return SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Every:",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            height: 35,
            child: TextField(
              controller: _frequencyEditingController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ref.read(formRecurrenceProvider).updateRecurrence(
                    updatedRecurrence.copyWith(occurrence: int.parse(value)));
              },
            ),
          ),
          const SizedBox(width: 20),
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: AppTheme.getTheme().disabledColor,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton<RecurrenceUnit>(
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              value: updatedRecurrence.unit,
              onChanged: (value) {
                ref
                    .read(formRecurrenceProvider)
                    .updateRecurrence(updatedRecurrence.copyWith(unit: value));
              },
              items:
                  RecurrenceUnit.values.map<DropdownMenuItem<RecurrenceUnit>>(
                (RecurrenceUnit value) {
                  return DropdownMenuItem<RecurrenceUnit>(
                    value: value,
                    child: Text(value.toString().split('.').last.capitalize()),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildSave() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onSelect(ref.read(formRecurrenceProvider).recurrence);
          },
          child: const Text('save'),
        ),
      ),
    );
  }
}
