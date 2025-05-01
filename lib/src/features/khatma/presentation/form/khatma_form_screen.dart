import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/repeat_enabler_tile.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma_ui/extentions/string_extensions.dart';
import 'package:khatma/src/constants/snack_bars.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/avatar.dart';
import 'package:khatma/src/widgets/buttons/delete_button.dart';
import 'package:khatma/src/widgets/buttons/primary_button.dart';
import 'package:khatma_ui/components/conditional_content.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/widgets/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_controller.dart';
import 'package:khatma/src/features/khatma/presentation/form/providers/khatma_form_provider.dart';
import 'package:khatma_ui/components/khatma_form_tile.dart';
import 'package:khatma_ui/components/modal_bottom_sheet.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/unit_selector.dart';
import 'package:khatma/src/routing/app_router.dart';

class AddKhatmaScreen extends ConsumerWidget {
  const AddKhatmaScreen({super.key, this.khatmaId});

  final String? khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(formKhatmaProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isBlank(khatma.id)
            ? AppLocalizations.of(context).newKhatma
            : AppLocalizations.of(context).editKhatma),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: khatma.id != khatmaId
          ? EmptyPlaceholderWidget(message: 'Khatma not found')
          : _buildFormView(context, khatma, ref),
    );
  }

  SafeArea _buildFormView(
    BuildContext context,
    Khatma khatma,
    WidgetRef ref,
  ) {
    final node = FocusScopeNode();
    final nameController = TextEditingController(text: khatma.name);
    final descController = TextEditingController(text: khatma.description);
    return SafeArea(
      child: SingleChildScrollView(
        child: FocusScope(
          node: node,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: khatma.style.hexColor.withOpacity(.1),
            child: _buildForm(
                context, khatma, ref, nameController, descController),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    Khatma khatma,
    WidgetRef ref,
    TextEditingController nameController,
    TextEditingController descController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH24,
          _buildAvatar(context, khatma, ref),
          gapH16,
          _buildName(context, nameController, descController, ref, khatma),
          gapH16,
          _buildDescription(
              context, nameController, descController, ref, khatma),
          gapH16,
          _buildSplitUnit(context, ref),
          gapH16,
          _buildEnableRepeat(khatma, ref),
          Spacer(),
          gapH20,
          _buildSaveButton(khatma, context, ref),
          gapH16,
          _buildDeleteButton(context, ref),
          gapH64,
          gapH16,
        ],
      ),
    );
  }

  Widget _buildEnableRepeat(Khatma khatma, WidgetRef ref) {
    return Card(
      child: RepeatKhatmaTile(
        enabled: khatma.repeat,
        onChanged: (enaled) =>
            ref.updateKhatma(khatma.copyWith(repeat: !khatma.repeat)),
      ),
    );
  }

  PrimaryButton _buildSaveButton(
      Khatma khatma, BuildContext context, WidgetRef ref) {
    return PrimaryButton(
      color: khatma.style.hexColor,
      width: double.infinity,
      shadowOffset: 8,
      text: AppLocalizations.of(context).save,
      onPressed: () {
        ref.read(khatmaControllerProvider.notifier).submit();
        Navigator.of(context).pop();
      },
    );
  }

  ConditionalContent _buildDeleteButton(BuildContext context, WidgetRef ref) {
    return ConditionalContent(
      condition: khatmaId != null,
      primary: DeleteButton(
        width: double.infinity,
        content: AppLocalizations.of(context).confirmDeleteKhatma,
        onPressed: () {
          final snackBar = buildSnackBar(
            context,
            Text(AppLocalizations.of(context).cancel),
          );
          ref.read(khatmaControllerProvider.notifier).delete(khatmaId!).then(
                (e) => {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar),
                  Timer(Duration(seconds: 1, microseconds: 100), () {
                    context.goNamed(AppRoute.home.name);
                  }),
                },
              );
        },
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, Khatma khatma, WidgetRef ref) {
    return Center(
      child: Avatar(
        backgroundColor: khatma.style.hexColor.withOpacity(.2),
        bottom: Avatar(
          radius: 10,
          backgroundColor: khatma.style.hexColor,
          child: const Icon(Icons.brush, size: 12),
        ),
        child: getIcon(
          khatma.style.icon,
          color: khatma.style.hexColor,
          size: 50,
        ),
        onTap: () => _showModal(
            context,
            KhatmaStyleSelector(
              style: khatma.style,
              onChanged: (value) => ref.updateKhatma(
                khatma.copyWith(theme: value),
              ),
            ),
            AppLocalizations.of(context).khatmaStyle),
      ),
    );
  }

  TextFormField _buildName(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController descController,
      WidgetRef ref,
      Khatma khatma) {
    return TextFormField(
      controller: nameController,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).nameHint,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      onTapOutside: (value) => ref.updateKhatma(khatma.copyWith(
          name: nameController.text, description: descController.text)),
    );
  }

  TextField _buildDescription(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController descController,
      WidgetRef ref,
      Khatma khatma) {
    return TextField(
      controller: descController,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).descriptionHint,
      ),
      onTapOutside: (value) => ref.updateKhatma(khatma.copyWith(
          name: nameController.text, description: descController.text)),
    );
  }

  Widget _buildSplitUnit(BuildContext context, WidgetRef ref) {
    Khatma khatma = ref.watch(formKhatmaProvider);
    return KhatmaFormTile(
      icon: const Icon(Icons.dynamic_feed, color: Colors.amber),
      title: AppLocalizations.of(context).splitUnit,
      subtitle: Text(
          AppLocalizations.of(context).khatmaSplitUnitDesc(khatma.unit.name)),
      onTap: () => khatma.isStarted
          ? showSnackBar(context)
          : _showModal(
              context,
              UnitSelector(
                  unit: khatma.unit,
                  onSelect: (value) => ref
                      .read(khatmaControllerProvider.notifier)
                      .updateUnit(khatma, value)),
              AppLocalizations.of(context).splitUnit,
            ),
    );
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cannot update khatma while it is started'),
    ));
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
    read(formKhatmaProvider.notifier).update(khatma);
  }
}
