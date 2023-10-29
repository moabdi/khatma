import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/utils/string_utils.dart';
import 'package:khatma/src/features/khatma/data/khatma_notifier.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/share_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_form_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/unit_selector.dart';
import 'package:khatma/src/localization/i10n_utils.dart';
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
                    _buildName(context, nameController, node, ref, khatma),
                    gapH20,
                    _buildDescription(context, descController, ref, khatma),
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
      child: InkWell(
        onTap: () => _showModal(
          context,
          KhatmaStyleSelector(
            style: khatma.style,
            onChanged: (value) => ref.read(formKhatmaProvider).updateKhatma(
                  khatma.copyWith(style: value),
                ),
          ),
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: HexColor(khatma.style.color).withOpacity(.2),
          child: Stack(children: [
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: FittedBox(
                    child: getImage(khatma.style.icon,
                        color: HexColor(khatma.style.color))),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: HexColor(khatma.style.color),
                child: Icon(Icons.edit, size: 12),
              ),
            ),
          ]),
        ),
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
          AppLocalizations.of(context).khatmaSplitUnitDesc(khatma.unit.value),
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
    Map<KhatmaScheduler, Icon> iconsMap = {
      KhatmaScheduler.never: Icon(Icons.block, color: Colors.grey),
      KhatmaScheduler.autoRepeat: Icon(Icons.autorenew, color: Colors.blue),
      KhatmaScheduler.custom:
          Icon(Icons.history_toggle_off_sharp, color: Colors.orange),
    };
    return KhatmaFormTile(
      icon: khatma.recurrence.scheduler == null
          ? iconsMap[KhatmaScheduler.never]!
          : iconsMap[khatma.recurrence.scheduler!]!,
      title: AppLocalizations.of(context).recurrence,
      subtitle: AppLocalizations.of(context)
          .khatmaSchedulerDesc(khatma.recurrence.scheduler.value),
      onTap: () {
        ref.read(formRecurrenceProvider).updateRecurrence(khatma.recurrence);
        _showModal(
          context,
          RecurrenceSelector(
              recurrence: khatma.recurrence,
              onSelect: (value) => ref
                  .read(formKhatmaProvider)
                  .updateKhatma(khatma.copyWith(recurrence: value))),
        );
      },
    );
  }

  KhatmaFormTile _buildShare(
      BuildContext context, Khatma khatma, WidgetRef ref) {
    Map<KhatmaShareType, Icon> shareTypeIcons = {
      KhatmaShareType.private:
          const Icon(FontAwesomeIcons.lock, color: Colors.orange),
      KhatmaShareType.public: const Icon(Icons.public, color: Colors.blue),
      KhatmaShareType.group: const Icon(Icons.group, color: Colors.purple),
    };

    return KhatmaFormTile(
      icon: khatma.share == null
          ? shareTypeIcons[KhatmaShareType.private]!
          : shareTypeIcons[khatma.share!]!,
      title: AppLocalizations.of(context).share,
      subtitle:
          AppLocalizations.of(context).khatmaShareTypeDesc(khatma.share!.value),
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
          label: Text(AppLocalizations.of(context).save),
        ),
      ),
    );
  }
}
