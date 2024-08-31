import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/common/constants/app_sizes.dart';
import 'package:khatma/src/common/constants/snack_bars.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/common/extensions/string_utils.dart';
import 'package:khatma/src/common/widgets/avatar.dart';
import 'package:khatma/src/common/buttons/delete_button.dart';
import 'package:khatma/src/common/buttons/primary_button.dart';
import 'package:khatma/src/common/widgets/conditional_content.dart';
import 'package:khatma/src/common/widgets/empty_placeholder_widget.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_utils.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/khatma_style/style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/reccurence_text.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/share_selector/share_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_controller.dart';
import 'package:khatma/src/features/khatma/presentation/form/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/khatma_form_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/recurrence_selector/recurrence_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/widgets/modal_bottom_sheet.dart';
import 'package:khatma/src/features/khatma/presentation/form/components/unit_selector.dart';
import 'package:khatma/src/routing/app_router.dart';

class AddKhatmaScreen extends ConsumerWidget {
  const AddKhatmaScreen({super.key, this.khatmaId});

  final String? khatmaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final khatma = ref.watch(formKhatmaProvider);
    final formKey = GlobalKey<FormState>();
    final node = FocusScopeNode();
    final nameController = TextEditingController(text: khatma.name);
    final descController = TextEditingController(text: khatma.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(isBlank(khatma.id)
            ? AppLocalizations.of(context).newKhatma
            : AppLocalizations.of(context).editKhatma),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: khatma.id != khatmaId
          ? EmptyPlaceholderWidget(message: 'Khatma not found')
          : SafeArea(
              child: SingleChildScrollView(
                child: FocusScope(
                  node: node,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAvatar(context, khatma, ref),
                          gapH20,
                          gapH20,
                          _buildName(context, nameController, descController,
                              node, ref, khatma),
                          gapH20,
                          _buildDescription(context, nameController,
                              descController, ref, khatma),
                          gapH20,
                          _buildSplitUnit(context, ref),
                          gapH20,
                          _buildRecurrence(context, ref),
                          gapH20,
                          _buildShare(context, ref),
                          gapH64,
                          PrimaryButton(
                            width: double.infinity,
                            shadowOffset: 8,
                            text: AppLocalizations.of(context).save,
                            onPressed: () {
                              ref
                                  .read(khatmaControllerProvider.notifier)
                                  .submit();
                              Navigator.of(context).pop();
                            },
                          ),
                          gapH20,
                          ConditionalContent(
                            condition: khatmaId != null,
                            primary: DeleteButton(
                              width: double.infinity,
                              content: AppLocalizations.of(context)
                                  .confirmDeleteKhatma,
                              onPressed: () {
                                final snackBar = buildSnackBar(
                                  context,
                                  Text(AppLocalizations.of(context).cancel),
                                );
                                ref
                                    .read(khatmaControllerProvider.notifier)
                                    .delete(khatmaId!)
                                    .then(
                                      (e) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar),
                                        Timer(
                                            Duration(
                                                seconds: 2,
                                                microseconds: 100), () {
                                          context.goNamed(AppRoute.home.name);
                                        }),
                                      },
                                    );
                              },
                            ),
                          ),
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
                khatma.copyWith(style: value),
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
      FocusScopeNode node,
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

  Widget _buildRecurrence(BuildContext context, WidgetRef ref) {
    Khatma khatma = ref.watch(formKhatmaProvider);
    return KhatmaFormTile(
      icon:
          const Icon(Icons.autorenew, color: Color.fromARGB(255, 120, 0, 212)),
      title: AppLocalizations.of(context).recurrence,
      subtitle: RecurrenceText(khatma.recurrence),
      onTap: () {
        ref.read(recurrenceNotifierProvider.notifier).update(khatma.recurrence);
        _showModal(
          context,
          RecurrenceSelector(
              recurrence: khatma.recurrence,
              onChanged: (value) =>
                  ref.updateKhatma(khatma.copyWith(recurrence: value))),
          AppLocalizations.of(context).recurrence,
        );
      },
    );
  }

  Widget _buildShare(BuildContext context, WidgetRef ref) {
    Khatma khatma = ref.watch(formKhatmaProvider);
    return KhatmaFormTile(
      icon: const Icon(
        Icons.group,
        color: Color.fromARGB(255, 0, 212, 102),
        size: 24,
      ),
      title: AppLocalizations.of(context).share,
      subtitle: Text(AppLocalizations.of(context)
          .shareVisibilityDesc(khatma.share.visibility.name)),
      onTap: () => khatma.isStarted
          ? showSnackBar(context)
          : {
              ref.read(shareNotifierProvider.notifier).update(khatma.share),
              _showModal(
                context,
                ShareSelector(
                    onChanged: (value) =>
                        ref.updateKhatma(khatma.copyWith(share: value))),
                AppLocalizations.of(context).share,
              )
            },
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
