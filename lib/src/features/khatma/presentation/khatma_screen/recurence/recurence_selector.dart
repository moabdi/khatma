import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RecurrenceSelector extends StatefulWidget {
  RecurrenceSelector({
    Key? key,
    required this.recurrence,
    required this.onSelect,
  }) : super(key: key);

  final Recurrence recurrence;
  final ValueChanged<Recurrence> onSelect;

  @override
  State<RecurrenceSelector> createState() => _RecurrenceSelectorState();
}

class _RecurrenceSelectorState extends State<RecurrenceSelector> {
  late final Recurrence updatedRecurrence;
  RecurrenceUnit selectedCustomRecurrenceValue = RecurrenceUnit.MONTHLY;
  final TextEditingController _startDateEditingController =
      TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );

  final TextEditingController _endDateEditingController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );

  final TextEditingController _frequencyEditingController =
      TextEditingController(text: '1');
  @override
  void initState() {
    super.initState();
    updatedRecurrence = widget.recurrence.copy();
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
      lastDate: DateTime(9999),
    );

    if (picked != null && picked != dateTime) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
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
            CloseButton(
              color: Color.fromARGB(255, 0, 212, 102),
              onPressed: (() {
                Navigator.pop(context);
              }),
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
          KhatmaScheduler.NEVER,
          "Does not repeat",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        _buildRecurrenceTile(
          context,
          KhatmaScheduler.AUTO_REPEAT,
          "Repeat after completing current",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        _buildRecurrenceTile(
          context,
          KhatmaScheduler.CUSTOM,
          "Custom",
          Icons.circle_outlined,
          AppTheme.getTheme().primaryColor.withOpacity(.1),
        ),
        _buildForm(),
        gapH20,
        gapH20,
      ],
    );
  }

  Widget _buildForm() {
    if (updatedRecurrence.scheduler == KhatmaScheduler.NEVER) {
      return SizedBox();
    }
    return Column(
      children: [
        _buildDateField(
          context,
          "Start date:",
          _startDateEditingController,
          updatedRecurrence.startDate,
        ),
        _recurrence(),
        _buildDateField(
          context,
          "End date:",
          _endDateEditingController,
          updatedRecurrence.endDate,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 212, 102)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
                //onSelect(this.recurrence);
              },
              child: Text('save'),
            ),
          ),
        )
      ],
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
    if (updatedRecurrence.scheduler == KhatmaScheduler.AUTO_REPEAT) {
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
                  updatedRecurrence.unit = newValue!;
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
        : AppTheme.getTheme().disabledColor;

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
          updatedRecurrence.scheduler = scheduler;
          widget.onSelect(updatedRecurrence);
        });
      },
    );
  }
}
