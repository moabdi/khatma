import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/khatma_avatar.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/khatma_style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_form_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/modal_bottom_sheet.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/unit_selector.dart';
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
        title: Text(AppLocalizations.of(context).newKhatma),
      ),
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
                    _buildAvatar(context, khatma, ref),
                    gapH20,
                    _buildName(context, nameController, node, ref, khatma),
                    gapH20,
                    _buildDescription(context, descController, ref, khatma),
                    gapH20,
                    _buildSplitUnit(khatma, context, ref),
                    gapH20,
                    _buildRecurrence(khatma, ref, context),
                    gapH20,
                    _buildShare(context, khatma, ref),
                    gapH48,
                    _saveButton(context, ref),
                    gapH64,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, Khatma khatma, WidgetRef ref) {
    return Center(
      child: InkWell(
        onTap: () => _showModal(
            context,
            KhatmaStyleSelector(
              style: khatma.style,
              onChanged: (value) => ref.updateKhatma(
                khatma.copyWith(style: value),
              ),
            ),
            AppLocalizations.of(context).chooseKhatmaStyle.withColon),
        child: KhatmaAvatar(style: khatma.style),
      ),
    );
  }

  TextFormField _buildName(
      BuildContext context,
      TextEditingController nameController,
      FocusScopeNode node,
      WidgetRef ref,
      Khatma khatma) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).nameHint,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );
  }

  TextField _buildDescription(BuildContext context,
      TextEditingController descController, WidgetRef ref, Khatma khatma) {
    return TextField(
      controller: descController,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).descriptionHint,
      ),
    );
  }

  KhatmaFormTile _buildSplitUnit(
      Khatma khatma, BuildContext context, WidgetRef ref) {
    return KhatmaFormTile(
      icon: const Icon(Icons.dynamic_feed, color: Colors.amber),
      title: AppLocalizations.of(context).splitUnit,
      subtitle:
          AppLocalizations.of(context).khatmaSplitUnitDesc(khatma.unit.name),
      onTap: () => _showModal(
        context,
        UnitSelector(
            unit: khatma.unit,
            onSelect: (value) {
              ref.updateKhatma(khatma.copyWith(unit: value));
            }),
        AppLocalizations.of(context).splitUnit.withColon,
      ),
    );
  }

  KhatmaFormTile _buildRecurrence(
      Khatma khatma, WidgetRef ref, BuildContext context) {
    return KhatmaFormTile(
      icon: const Icon(Icons.rotate_right,
          color: Color.fromARGB(255, 120, 0, 212)),
      title: AppLocalizations.of(context).recurrence,
      subtitle: AppLocalizations.of(context)
          .khatmaSchedulerDesc(khatma.recurrence.scheduler.name),
      onTap: () {
        ref.read(formRecurrenceProvider).updateRecurrence(khatma.recurrence);
        _showModal(
          context,
          RecurrenceSelector(
              recurrence: khatma.recurrence,
              onSelect: (value) =>
                  ref.updateKhatma(khatma.copyWith(recurrence: value))),
          AppLocalizations.of(context).recurrence.withColon,
        );
      },
    );
  }

  KhatmaFormTile _buildShare(
      BuildContext context, Khatma khatma, WidgetRef ref) {
    return KhatmaFormTile(
      icon: const Icon(Icons.group, color: Color.fromARGB(255, 0, 212, 102)),
      title: AppLocalizations.of(context).share,
      subtitle:
          AppLocalizations.of(context).khatmaShareTypeDesc(khatma.share.name),
      onTap: () => _showModal(
        context,
        ShareSelector(
            unit: khatma.share,
            onSelect: (value) =>
                ref.updateKhatma(khatma.copyWith(share: value))),
        AppLocalizations.of(context).share.withColon,
      ),
    );
  }

  _saveButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context).save),
      ),
    );
  }

  void _showModal(BuildContext context, Widget child, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ModalBottomSheet(
          title: title,
          child: child,
        );
      },
    );
  }
}

extension ProviderRef on WidgetRef {
  updateKhatma(Khatma khatma) {
    read(formKhatmaProvider).updateKhatma(khatma);
  }
}
