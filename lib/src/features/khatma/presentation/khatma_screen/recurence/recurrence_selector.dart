import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RecurrenceSelector extends StatefulWidget {
  const RecurrenceSelector({
    super.key,
    required this.recurrence,
    required this.onSelect,
  });

  final Recurrence recurrence;
  final ValueChanged<Recurrence> onSelect;

  @override
  State<RecurrenceSelector> createState() => _RecurrenceSelectorState();
}

class _RecurrenceSelectorState extends State<RecurrenceSelector> {
  late RecurrenceUnit selectedCustomRecurrenceValue;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _startDateEditingController =
      TextEditingController();

  final TextEditingController _endDateEditingController =
      TextEditingController();

  final TextEditingController _frequencyEditingController =
      TextEditingController(text: '1');

  final DateTime maxEndDate = DateTime.now().add(const Duration(days: 3600));

  late Recurrence updatedRecurrence;

  @override
  void initState() {
    super.initState();
    updatedRecurrence = widget.recurrence.copyWith();
    selectedCustomRecurrenceValue =
        widget.recurrence.unit ?? RecurrenceUnit.monthly;
    _startDateEditingController.text =
        _dateFormat.format(widget.recurrence.startDate);
    _endDateEditingController.text =
        _dateFormat.format(widget.recurrence.endDate);
    _frequencyEditingController.text = widget.recurrence.occurrence.toString();
  }

  @override
  void dispose() {
    _frequencyEditingController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    DateTime dateTime,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: maxEndDate,
    );

    if (picked != null && picked != dateTime) {
      controller.text = _dateFormat.format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Set recurrence:",
            style: AppTheme.getTheme().textTheme.titleLarge,
          ),
        ),
        _buildRecurrenceTile(
          context,
          KhatmaScheduler.never,
          "Does not repeat",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        _buildRecurrenceTile(
          context,
          KhatmaScheduler.autoRepeat,
          "Repeat after completing current",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        _buildRecurrenceTile(
          context,
          KhatmaScheduler.custom,
          "Custom",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 600),
          child: _buildForm(),
        ),
        gapH20,
        gapH20,
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(indent: 1),
        ),
        _buildDateField(
          context,
          "Start date:",
          _startDateEditingController,
          updatedRecurrence.startDate,
        ),
        _buildDateField(
          context,
          "End date:",
          _endDateEditingController,
          updatedRecurrence.endDate,
        ),
        _recurrence(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(indent: 1),
        ),
        buildSave(),
      ],
    );
  }

  Container buildSave() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () {
            updatedRecurrence = updatedRecurrence.copyWith(
              startDate: _dateFormat.parse(_startDateEditingController.text),
              endDate: _dateFormat.parse(_endDateEditingController.text),
              occurrence: _frequencyEditingController.text.isEmpty
                  ? 0
                  : int.parse(_frequencyEditingController.text),
              unit: selectedCustomRecurrenceValue,
            );
            Navigator.pop(context);
            widget.onSelect(updatedRecurrence);
          },
          child: const Text('save'),
        ),
      ),
    );
  }

  Padding _buildDateField(
    BuildContext context,
    String label,
    TextEditingController controller,
    DateTime dateTime,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            height: 40,
            child: TextField(
              controller: controller,
              onTap: () => _selectDate(
                context,
                controller,
                dateTime,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recurrence() {
    if (updatedRecurrence.scheduler == KhatmaScheduler.autoRepeat) {
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
                _frequencyEditingController.text = value;
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
              value: selectedCustomRecurrenceValue,
              onChanged: (newValue) {
                setState(() {
                  updatedRecurrence =
                      updatedRecurrence.copyWith(unit: newValue!);
                  selectedCustomRecurrenceValue = newValue;
                });
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

  ListTile _buildRecurrenceTile(
    BuildContext context,
    KhatmaScheduler scheduler,
    String title,
    IconData icon,
    Color tileColor,
  ) {
    bool isSelected = updatedRecurrence.scheduler == scheduler;
    final Color iconColor = isSelected
        ? AppTheme.getTheme().primaryColor
        : AppTheme.getTheme().dividerColor;

    return ListTile(
      dense: true,
      tileColor: isSelected ? tileColor : null,
      title: Text(scheduler.name),
      subtitle: Text(
        title,
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
          size: 32,
          color: iconColor,
        ),
      ),
      onTap: () {
        setState(() {
          updatedRecurrence = updatedRecurrence.copyWith(scheduler: scheduler);
        });
      },
    );
  }
}
