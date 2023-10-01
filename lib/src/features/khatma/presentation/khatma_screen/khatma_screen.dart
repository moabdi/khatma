import 'package:flutter/material.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/constants/test_khatmat.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/unit_selector.dart';
import 'package:khatma/src/themes/theme.dart';

class AddKhatmaScreen extends StatefulWidget {
  const AddKhatmaScreen({Key? key}) : super(key: key);

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
        title: const Text("New Khatma"),
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
                  buildListTile(
                    Icons.dynamic_feed,
                    Colors.amber,
                    "Split unit",
                    "${khatma.unit.name.capitalize()} (${khatma.unit.count} parts)",
                    () => _showModal(
                      context,
                      UnitSelector(
                        unit: khatma.unit,
                        onSelect: (value) => setState(() {
                          khatma.unit = value;
                        }),
                      ),
                    ),
                  ),
                  gapH20,
                  buildListTile(
                    Icons.rotate_right,
                    Color.fromARGB(255, 120, 0, 212),
                    'Repeat',
                    khatma.recurrence.scheduler.name,
                    () => _showModal(
                      context,
                      RecurrenceSelector(
                        recurrence: khatma.recurrence,
                        onSelect: (value) => setState(() {
                          khatma.recurrence = value;
                        }),
                      ),
                    ),
                  ),
                  gapH20,
                  buildListTile(
                    Icons.group,
                    Color.fromARGB(255, 0, 212, 102),
                    'Share',
                    "Individual",
                    () => _showModal(
                      context,
                      RecurrenceSelector(
                        recurrence: khatma.recurrence,
                        onSelect: (value) => setState(() {
                          khatma.recurrence = value;
                        }),
                      ),
                    ),
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

  ListTile buildListTile(IconData icon, Color color, String title,
      String subtitle, Function onTap) {
    return ListTile(
      dense: true,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: AppTheme.getTheme().textTheme.subtitle2,
      ),
      onTap: () => onTap(),
      trailing: Icon(Icons.arrow_right),
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
