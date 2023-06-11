import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';
import 'package:khatma/src/themes/theme.dart';

class AddKhatmaScreen extends StatefulWidget {
  @override
  State<AddKhatmaScreen> createState() => _AddKhatmaScreenState();
}

class _AddKhatmaScreenState extends State<AddKhatmaScreen> {
  SplitUnit _selectedSplitUnit = SplitUnit.hizb;
  KhatmaScheduler _selectedScheduler = KhatmaScheduler.never;
  KhatmaType _selectedKhatmaType = KhatmaType.monthly;
  bool _isPermanent = true;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _startDateEditingController =
      TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _endDateEditingController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController _frequenceEditingController =
      TextEditingController(text: '1');
  String selectedValue = 'Month';

  List<String> dropdownItems = [
    'Day',
    'Week',
    'Month',
    'Month Hijri',
    'Year',
  ];

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("New khatma"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH20,
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter the name of the Khatma',
                ),
              ),
              gapH20,
              const TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter a description (optional)',
                ),
              ),
              gapH20,
              ListTile(
                leading: const Icon(
                  Icons.dynamic_feed,
                  color: Colors.amber,
                ),
                title: Text("Split unit"),
                subtitle: Text(
                  "${_selectedSplitUnit.name.capitalize()} (${_selectedSplitUnit.value} parts)",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showSplitUnitModal(context, splitUnitSelector()),
                trailing: Icon(Icons.arrow_right),
              ),
              gapH20,
              ListTile(
                leading: const Icon(
                  Icons.rotate_right,
                  color: Color.fromARGB(255, 120, 0, 212),
                ),
                title: const Text('Repate'),
                subtitle: Text(
                  "Never",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showSplitUnitModal(context, shcedulerSelector()),
                trailing: Icon(Icons.arrow_right),
              ),
              gapH20,
              ListTile(
                leading: const Icon(
                  Icons.schedule,
                  color: Color.fromARGB(255, 0, 81, 212),
                ),
                title: const Text('Scheduler'),
                subtitle: Text(
                  "Never",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showSplitUnitModal(context, shcedulerSelector()),
                trailing: Icon(Icons.arrow_right),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  void _showSplitUnitModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Ink(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: AppTheme.getTheme().listTileTheme.tileColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: widget,
        );
      },
    );
  }

  Column splitUnitSelector() {
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
          child: Text("Split Unit :",
              style: AppTheme.getTheme().textTheme.titleLarge),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: SplitUnit.values.length,
          itemBuilder: (BuildContext context, int index) {
            var unit = SplitUnit.values[index];
            var selected = _selectedSplitUnit == unit;
            return ListTile(
              dense: true,
              tileColor: selected
                  ? AppTheme.getTheme().primaryColor.withOpacity(.1)
                  : null,
              title: Text(unit.name.capitalize()),
              subtitle: Text(
                "${unit.value} parts",
                style: AppTheme.getTheme().textTheme.subtitle2,
              ),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  size: 32,
                  color: selected
                      ? AppTheme.getTheme().primaryColor
                      : AppTheme.getTheme().disabledColor,
                ),
              ),
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                  _selectedSplitUnit = unit;
                });
              },
            );
          },
        ),
        gapH20,
      ],
    );
  }

  Column shcedulerSelector() {
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
        ListTile(
          dense: true,
          tileColor: _selectedScheduler == KhatmaScheduler.never
              ? AppTheme.getTheme().primaryColor.withOpacity(.1)
              : null,
          title: Text(KhatmaScheduler.never.name.capitalize()),
          subtitle: Text(
            "Does not repeat",
            style: AppTheme.getTheme().textTheme.subtitle2,
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
        ),
        ListTile(
          dense: true,
          tileColor: _selectedScheduler == KhatmaScheduler.done
              ? AppTheme.getTheme().primaryColor.withOpacity(.1)
              : null,
          title: Text(KhatmaScheduler.done.name.capitalize()),
          subtitle: Text(
            "Repeat after completing current",
            style: AppTheme.getTheme().textTheme.subtitle2,
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              _selectedScheduler == KhatmaScheduler.done
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              size: 32,
              color: _selectedScheduler == KhatmaScheduler.done
                  ? AppTheme.getTheme().primaryColor
                  : AppTheme.getTheme().disabledColor,
            ),
          ),
          onTap: () {
            setState(() {
              Navigator.pop(context);
              _selectedScheduler = KhatmaScheduler.done;
            });
          },
        ),
        ListTile(
          dense: true,
          tileColor: _selectedScheduler == KhatmaScheduler.custom
              ? AppTheme.getTheme().primaryColor.withOpacity(.1)
              : null,
          title: Text(KhatmaScheduler.custom.name.capitalize()),
          subtitle: Text(
            "Custom",
            style: AppTheme.getTheme().textTheme.subtitle2,
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
        ),
        Padding(
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
                    onTap: () =>
                        _selectDate(context, _startDateEditingController),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
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
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  underline: SizedBox(),
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
                  items: dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Padding(
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
                    onTap: () =>
                        _selectDate(context, _endDateEditingController),
                  ),
                ),
              ),
            ],
          ),
        ),
        gapH20,
        gapH20,
      ],
    );
  }
}
