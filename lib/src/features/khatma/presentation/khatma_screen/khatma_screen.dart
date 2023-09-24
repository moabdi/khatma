import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/recurence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/unit_selector.dart';
import 'package:khatma/src/themes/theme.dart';

class AddKhatmaScreen extends StatefulWidget {
  const AddKhatmaScreen({super.key});

  @override
  State<AddKhatmaScreen> createState() => _AddKhatmaScreenState();
}

class _AddKhatmaScreenState extends State<AddKhatmaScreen> {
  final SplitUnit _selectedSplitUnit = SplitUnit.HIZB;
  List<bool> _isSelected = [true, false]; // Two values
  Khatma khatma = kTestKhatmat[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New khatma"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                dense: true,
                leading: const Icon(
                  Icons.dynamic_feed,
                  color: Colors.amber,
                ),
                title: const Text("Split unit"),
                subtitle: Text(
                  "${khatma.unit.name.capitalize()} (${khatma.unit.count} parts)",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showModal(
                    context,
                    UnitSelector(
                      unit: khatma.unit,
                      onSelect: (value) => setState(() {
                        khatma.unit = value;
                      }),
                    )),
                trailing: Icon(Icons.arrow_right),
              ),
              gapH20,
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.rotate_right,
                  color: Color.fromARGB(255, 120, 0, 212),
                ),
                title: const Text('Repeat'),
                subtitle: Text(
                  khatma.recurrence.scheduler.name,
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showModal(
                    context,
                    RecurrenceSelector(
                      recurrence: khatma.recurrence,
                      onSelect: (value) => setState(() {
                        khatma.recurrence = value;
                      }),
                    )),
                trailing: Icon(Icons.arrow_right),
              ),
              gapH20,
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.group,
                  color: Color.fromARGB(255, 0, 212, 102),
                ),
                title: const Text('Share'),
                subtitle: Text(
                  "Individual",
                  style: AppTheme.getTheme().textTheme.subtitle2,
                ),
                onTap: () => _showModal(
                    context,
                    RecurrenceSelector(
                      recurrence: khatma.recurrence,
                      onSelect: (value) => setState(() {
                        khatma.recurrence = value;
                      }),
                    )),
                trailing: Icon(Icons.arrow_right),
              ),
              gapH20,
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context, Widget widget) {
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
}
