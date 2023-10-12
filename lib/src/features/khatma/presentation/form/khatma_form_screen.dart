import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/form/recurence/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/recurence/unit_selector.dart';
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
                  _buildName(nameController, node, ref, khatma),
                  gapH20,
                  _buildDescription(descController, ref, khatma),
                  gapH20,
                  _buildSplitUnit(khatma, context, ref),
                  gapH20,
                  _buildRecurrence(khatma, ref, context),
                  gapH20,
                  _buildShare(context, khatma, ref),
                  gapH20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildName(TextEditingController nameController,
      FocusScopeNode node, WidgetRef ref, Khatma khatma) {
    return TextFormField(
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
    );
  }

  TextField _buildDescription(
      TextEditingController descController, WidgetRef ref, Khatma khatma) {
    return TextField(
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
    );
  }

  KhatmaFormTile _buildSplitUnit(
      Khatma khatma, BuildContext context, WidgetRef ref) {
    return KhatmaFormTile(
      icon: const Icon(Icons.dynamic_feed, color: Colors.amber),
      title: "Split unit",
      subtitle: "${khatma.unit.name.capitalize()} (${khatma.unit.count} parts)",
      onTap: () => _showModal(
        context,
        UnitSelector(
            unit: khatma.unit,
            onSelect: (value) {
              ref
                  .watch(formKhatmaProvider)
                  .updateKhatma(khatma.copyWith(unit: value));
            }),
      ),
    );
  }

  KhatmaFormTile _buildRecurrence(
      Khatma khatma, WidgetRef ref, BuildContext context) {
    return KhatmaFormTile(
      icon: const Icon(Icons.rotate_right,
          color: Color.fromARGB(255, 120, 0, 212)),
      title: 'Repeat',
      subtitle: khatma.recurrence.scheduler.name,
      onTap: () {
        ref.read(formRecurrenceProvider).updateRecurrence(khatma.recurrence);

        _showModal(
          context,
          RecurrenceSelector(
              recurrence: khatma.recurrence,
              onSelect: (value) => ref
                  .watch(formKhatmaProvider)
                  .updateKhatma(khatma.copyWith(recurrence: value))),
        );
      },
    );
  }

  KhatmaFormTile _buildShare(
      BuildContext context, Khatma khatma, WidgetRef ref) {
    return KhatmaFormTile(
      icon: const Icon(Icons.group, color: Color.fromARGB(255, 0, 212, 102)),
      title: 'Share',
      subtitle: "Individual",
      onTap: () => _showModal(
        context,
        RecurrenceSelector(
            recurrence: khatma.recurrence,
            onSelect: (value) => ref
                .watch(formKhatmaProvider)
                .updateKhatma(khatma.copyWith(recurrence: value))),
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
