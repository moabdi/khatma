import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/share_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_form_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/unit_selector.dart';
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
      floatingActionButton: _saveButton(context, ref),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FocusScope(
            node: node,
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIcon(context, khatma, ref),
                    gapH20,
                    _buildName(nameController, node, ref, khatma),
                    gapH20,
                    _buildDescription(descController, ref, khatma),
                    gapH20,
                    _buildSplitUnit(khatma, context, ref),
                    gapH20,
                    _buildRecurrence(khatma, ref, context),
                    gapH20,
                    _buildShare(context, khatma, ref),
                    gapH64,
                    gapH20,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, Khatma khatma, WidgetRef ref) {
    return Center(
      child: CircleAvatar(
        radius: 40,
        backgroundColor: AppTheme.getTheme().cardColor,
        child: Stack(children: [
          InkWell(
            onTap: () => _showModal(
              context,
              KhatmaStyleSelector(
                style: khatma.style,
                onChanged: (value) => ref.read(formKhatmaProvider).updateKhatma(
                      khatma.copyWith(
                        style: KhatmaStyle(
                            icon: value,
                            color: AppTheme.getTheme().primaryColor.toString()),
                      ),
                    ),
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: FittedBox(
                    child: getImage(khatma.style.icon, color: Colors.amber)),
              ),
            ),
          ),
        ]),
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
                  .read(formKhatmaProvider)
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
      subtitle:
          khatma.share == null ? ShareType.individual.name : khatma.share!.name,
      onTap: () => _showModal(
        context,
        ShareSelector(
            unit: khatma.share!,
            onSelect: (value) => ref
                .read(formKhatmaProvider)
                .updateKhatma(khatma.copyWith(share: value))),
      ),
    );
  }

  void _showModal(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
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

  _saveButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: FloatingActionButton.extended(
          backgroundColor: AppTheme.getTheme().primaryColor,
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text("Save"),
        ),
      ),
    );
  }
}
