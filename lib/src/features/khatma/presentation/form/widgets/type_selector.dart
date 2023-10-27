import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/themes/theme.dart';

import 'package:khatma/src/features/khatma/domain/khatma.dart';

class TypeSelector extends StatefulWidget {
  const TypeSelector({super.key});

  @override
  State<TypeSelector> createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  KhatmaScheduler _selectedScheduler = KhatmaScheduler.never;
  DateTime selectedDate = DateTime.now();

  final TextEditingController _startDateEditingController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController _endDateEditingController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  final TextEditingController _frequenceEditingController =
      TextEditingController(text: '1');

  String selectedValue = 'Month';

  List<String> dropdownItems = ['Day', 'Week', 'Month', 'Month Hijri', 'Year'];

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(9999),
    );

    if (picked != null && picked != selectedDate) {
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
                  style: AppTheme.getTheme().textTheme.titleSmall,
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
                onTap: () => _selectDate(context, _endDateEditingController),
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
                  style: AppTheme.getTheme().textTheme.titleSmall,
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
            child: DropdownButton<String>(
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              //style: TextStyle(
              // color: Colors.blue, // Text color
              // fontSize: 18.0, // Text size
              // fontWeight: FontWeight.bold, // Text weight
              //  ),
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items:
                  dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
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
                  style: AppTheme.getTheme().textTheme.titleSmall,
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
                onTap: () => _selectDate(context, _startDateEditingController),
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
      tileColor: _selectedScheduler == KhatmaScheduler.never
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.never.name.capitalize()),
      subtitle: Text(
        "Does not repeat",
        style: AppTheme.getTheme().textTheme.titleSmall,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          _selectedScheduler == KhatmaScheduler.never
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: _selectedScheduler == KhatmaScheduler.never
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          _selectedScheduler = KhatmaScheduler.never;
        });
      },
    );
  }

  ListTile _customRepeat(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: _selectedScheduler == KhatmaScheduler.custom
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.custom.name.capitalize()),
      subtitle: Text(
        "Custom",
        style: AppTheme.getTheme().textTheme.titleSmall,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          _selectedScheduler == KhatmaScheduler.custom
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: _selectedScheduler == KhatmaScheduler.custom
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          _selectedScheduler = KhatmaScheduler.custom;
        });
      },
    );
  }

  ListTile _repeatAfterComplete(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: _selectedScheduler == KhatmaScheduler.autoRepeat
          ? AppTheme.getTheme().primaryColor.withOpacity(.1)
          : null,
      title: Text(KhatmaScheduler.autoRepeat.name.capitalize()),
      subtitle: Text(
        "Repeat after completing current",
        style: AppTheme.getTheme().textTheme.titleSmall,
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          _selectedScheduler == KhatmaScheduler.autoRepeat
              ? Icons.check_circle_rounded
              : Icons.circle_outlined,
          size: 32,
          color: _selectedScheduler == KhatmaScheduler.autoRepeat
              ? AppTheme.getTheme().primaryColor
              : AppTheme.getTheme().disabledColor,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.pop(context);
          _selectedScheduler = KhatmaScheduler.autoRepeat;
        });
      },
    );
  }
}
