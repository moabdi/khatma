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
  Khatma khatma = kTestKhatmat[0];

  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New khatma"),
      ),
      body: SingleChildScrollView(
        child: FocusScope(
          node: _node,
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the name of the Khatma',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => _node.nextFocus(),
                  ),
                  gapH20,
                  TextField(
                    controller: _descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
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
