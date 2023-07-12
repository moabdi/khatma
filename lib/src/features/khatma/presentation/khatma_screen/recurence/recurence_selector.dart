import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class RecurenceSelector extends StatefulWidget {
  RecurenceSelector(
      {super.key, required this.recurrence, required this.onSelect});
  final Recurrence recurrence;
  final ValueChanged<Recurrence> onSelect;

  @override
  State<RecurenceSelector> createState() => _RecurenceSelectorState();
}

class _RecurenceSelectorState extends State<RecurenceSelector> {
  final TextEditingController _startDateEditingController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController _endDateEditingController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController _frequenceEditingController =
      TextEditingController(text: '1');

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime dateTime) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
    );

    if (picked != null && picked != dateTime) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
        ;
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text("Set recurrence :",
              style: AppTheme.getTheme().textTheme.titleLarge),
        ),
        _neverRepeat(context),
        _repeatAfterComplete(context),
        _customRepeat(context),
        Column(
          children: [
            _startDate(context),
            _recurence(),
            _endDate(context),
          ],
        ),
        gapH20,
        gapH20,
      ],
    );
  }

  Padding _endDate(BuildContext context) {
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
                  "End date:",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            height: 40,
            child: Expanded(
              child: TextField(
                controller: _endDateEditingController,
                onTap: () => _selectDate(context, _endDateEditingController,
                    widget.recurrence.endDate),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _recurence() {
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
                  "Evry:",
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
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _frequenceEditingController.text = value;
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
              //style: TextStyle(
              // color: Colors.blue, // Text color
              // fontSize: 18.0, // Text size
              // fontWeight: FontWeight.bold, // Text weight
              //  ),
              value: widget.recurrence.unit,
              onChanged: (newValue) {
                widget.recurrence.unit = newValue!;
              },
              items: RecurrenceUnit.values
                  .map<DropdownMenuItem<RecurrenceUnit>>(
                      (RecurrenceUnit value) {
                return DropdownMenuItem<RecurrenceUnit>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Padding _startDate(BuildContext context) {
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
                  "Start date:",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            height: 40,
            child: Expanded(
              child: TextField(
                controller: _startDateEditingController,
                onTap: () => _selectDate(context, _startDateEditingController,
                    widget.recurrence.startDate),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _neverRepeat(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: widget.recurrence.occurrence == KhatmaScheduler.NEVER
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.NEVER.name.capitalize()),
      subtitle: Text(
        "Does not repeat",
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          widget.recurrence.occurrence == KhatmaScheduler.NEVER
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: widget.recurrence.occurrence == KhatmaScheduler.NEVER
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        widget.recurrence.scheduler = KhatmaScheduler.NEVER;
        widget.onSelect(widget.recurrence);
      },
    );
  }

  ListTile _customRepeat(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: widget.recurrence.occurrence == KhatmaScheduler.CUSTOM
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.CUSTOM.name.capitalize()),
      subtitle: Text(
        "Custom",
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          widget.recurrence.occurrence == KhatmaScheduler.CUSTOM
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: widget.recurrence.occurrence == KhatmaScheduler.CUSTOM
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        widget.recurrence.scheduler = KhatmaScheduler.CUSTOM;
        widget.onSelect(widget.recurrence);
      },
    );
  }

  ListTile _repeatAfterComplete(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: widget.recurrence.occurrence == KhatmaScheduler.AUTO_REPEAT
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.AUTO_REPEAT.name.capitalize()),
      subtitle: Text(
        "Repeat after completing current",
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          widget.recurrence.occurrence == KhatmaScheduler.AUTO_REPEAT
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: widget.recurrence.occurrence == KhatmaScheduler.AUTO_REPEAT
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        widget.recurrence.scheduler = KhatmaScheduler.AUTO_REPEAT;
        widget.onSelect(widget.recurrence);
      },
    );
  }
}
