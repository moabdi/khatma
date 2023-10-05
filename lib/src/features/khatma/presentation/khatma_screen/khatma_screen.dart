import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/khatma_screen/recurence/unit_selector.dart';
import 'package:khatma/src/themes/theme.dart';

class AddKhatmaScreen extends ConsumerWidget {
  const AddKhatmaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(formKhatmaProvider).khatma;
    final formKey = GlobalKey<FormState>();
    final node = FocusScopeNode();
    final nameController = TextEditingController(text: khatma.name);
    final descController =
        TextEditingController(text: khatma.description ?? '');
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Khatma"),
      ),
      body: SingleChildScrollView(
        child: FocusScope(
          node: node,
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the name of the Khatma',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (value) {
                      ref
                          .watch(formKhatmaProvider)
                          .updateKhatma(khatma.copyWith(name: value));
                    },
                  ),
                  gapH20,
                  TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Enter a description (optional)',
                    ),
                    onChanged: (value) {
                      ref
                          .watch(formKhatmaProvider)
                          .updateKhatma(khatma.copyWith(description: value));
                    },
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
                          onSelect: (value) {
                            ref
                                .watch(formKhatmaProvider)
                                .updateKhatma(khatma.copyWith(unit: value));
                          }),
                    ),
                  ),
                  gapH20,
                  buildListTile(
                    Icons.rotate_right,
                    Color.fromARGB(255, 120, 0, 212),
                    'Repeat',
                    ref
                        .watch(formKhatmaProvider)
                        .khatma
                        .recurrence
                        .scheduler
                        .name,
                    () => _showModal(
                      context,
                      RecurrenceSelector(
                          recurrence: khatma.recurrence,
                          onSelect: (value) => ref
                              .watch(formKhatmaProvider)
                              .updateKhatma(
                                  khatma.copyWith(recurrence: value))),
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
                          onSelect: (value) => ref
                              .watch(formKhatmaProvider)
                              .updateKhatma(
                                  khatma.copyWith(recurrence: value))),
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
      onTap: () {
        onTap();
        //ref.read(khatmaProvider.notifier).updateKhatma(null);
      },
      trailing: Icon(Icons.arrow_right),
    );
  }
}
