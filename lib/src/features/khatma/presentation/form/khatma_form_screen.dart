import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/core/app_dialog.dart';
import 'package:khatma/src/features/khatma/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_avatar.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/repeat_enabler_tile.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/constants/snack_bars.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma_ui/components/modal_bottom_sheet.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/unit_selector.dart';
import 'package:khatma/src/routing/app_router.dart';

class AddKhatmaScreen extends ConsumerStatefulWidget {
  const AddKhatmaScreen({super.key, this.khatmaId});

  final String? khatmaId;

  @override
  ConsumerState<AddKhatmaScreen> createState() => _AddKhatmaScreenState();
}

class _AddKhatmaScreenState extends ConsumerState<AddKhatmaScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final FocusScopeNode _focusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    // Initialize controllers with current khatma data
    final khatma = ref.read(khatmaFormProvider);
    _nameController = TextEditingController(text: khatma.name);
    _descController = TextEditingController(text: khatma.description);

    // Listen to controller changes and update the provider
    _nameController.addListener(_onTextFieldChanged);
    _descController.addListener(_onTextFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextFieldChanged() {
    final khatma = ref.read(khatmaFormProvider);
    ref.read(khatmaFormProvider.notifier).update(
          khatma.copyWith(
            name: _nameController.text,
            description: _descController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final khatma = ref.watch(khatmaFormProvider);
    final isEditing = widget.khatmaId != null;

    return Scaffold(
      appBar: _buildAppBar(context, isEditing),
      body: _buildBody(context, khatma),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isEditing) {
    return AppBar(
      centerTitle: true,
      title: Text(
        isEditing
            ? AppLocalizations.of(context).editKhatma
            : AppLocalizations.of(context).newKhatma,
      ),
      leading: BackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Khatma khatma) {
    // Check if we're editing a khatma that doesn't match the current ID
    if (widget.khatmaId != null && khatma.id != widget.khatmaId) {
      return const EmptyPlaceholderWidget(message: 'Khatma not found');
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: FocusScope(
          node: _focusNode,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: _buildForm(context, khatma),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, Khatma khatma) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH24,
            KhatmaAvatarMaterial(
              khatma: khatma,
              onTap: () => _showStyleSelector(context, khatma),
            ),
            gapH16,
            _buildNameField(context, khatma),
            gapH16,
            _buildDescriptionField(context, khatma),
            gapH16,
            _buildSplitUnitSelector(context, khatma),
            gapH16,
            _buildRepeatToggle(khatma),
            gapH48,
            ElevatedButton(
              child: Text(AppLocalizations.of(context).save),
              onPressed: () => _handleSave(context, khatma),
            ),
            gapH16,
            _buildDeleteButton(context),
            gapH24,
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context, Khatma khatma) {
    return ListenableBuilder(
      listenable: _nameController,
      builder: (context, _) {
        return TextFormField(
          controller: _nameController,
          style: context.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: context.loc.nameHint,
            labelText: context.loc.name,
            prefixIcon: const Icon(Icons.drive_file_rename_outline),
            suffixIcon: _nameController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _nameController.clear(),
                  )
                : null,
            counterText: '${_nameController.text.length}/50',
          ),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autocorrect: false,
          maxLength: 50,
          validator: (value) => _validateName(context, value),
        );
      },
    );
  }

  Widget _buildDescriptionField(BuildContext context, Khatma khatma) {
    return TextField(
      controller: _descController,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).descriptionHint,
        border: const OutlineInputBorder(),
      ),
      maxLength: 200,
    );
  }

  Widget _buildSplitUnitSelector(BuildContext context, Khatma khatma) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        leading: CircleAvatar(
          backgroundColor: context.theme.primaryColor.withAlpha(25),
          child: Icon(
            Icons.apps,
            color: context.colorScheme.primary,
            size: 32,
          ),
        ),
        title: Text(AppLocalizations.of(context).splitUnit),
        subtitle: Text(
          AppLocalizations.of(context).khatmaSplitUnitDesc(khatma.unit.name),
        ),
        onTap: () => _handleSplitUnitTap(context, khatma),
      ),
    );
  }

  void _handleSplitUnitTap(BuildContext context, Khatma khatma) {
    if (khatma.isStarted) {
      _showSnackBar(context, context.loc.cannotUpdateKhatmaWhileStarted);
      return;
    }

    _showModal(
      context,
      UnitSelector(
        unit: khatma.unit,
        onSelect: (value) =>
            ref.read(khatmaFormProvider.notifier).updateUnit(khatma, value),
      ),
      AppLocalizations.of(context).splitUnit,
    );
  }

  Widget _buildRepeatToggle(Khatma khatma) {
    return Card(
      child: RepeatKhatmaTile(
        enabled: khatma.repeat,
        onChanged: (enabled) => ref.read(khatmaFormProvider.notifier).update(
              khatma.copyWith(repeat: enabled),
            ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    final khatma = ref.watch(khatmaFormProvider);
    if (khatma.id == null) return const SizedBox.shrink();

    return OutlinedButton.icon(
      onPressed: () => _handleDelete(context, khatma),
      icon: Icon(Icons.delete),
      label: Text(AppLocalizations.of(context).delete),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.red.shade50,
        foregroundColor: Colors.red,
        side: BorderSide(color: Colors.red),
      ),
    );
  }

  String? _validateName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.nameCannotBeEmpty;
    }
    if (value.trim().length < 2) {
      return context.loc.nameMinLength;
    }
    return null;
  }

  Future<void> _handleSave(BuildContext context, Khatma khatma) async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref.read(khatmaNotifierProvider.notifier).saveKhatma(khatma);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        _showSnackBar(context, context.loc.failedToSaveKhatma);
      }
    }
  }

  Future<void> _handleDelete(BuildContext context, Khatma khatma) async {
    if (khatma.id == null) return;

    try {
      final shouldDelete = await AppDialog.showDelete(
        context,
        itemName: khatma.name,
      );

      if (!shouldDelete!) return;

      await ref
          .read(khatmaNotifierProvider.notifier)
          .deleteKhatma(widget.khatmaId!);

      if (mounted) {
        final snackBar = buildSnackBar(
          context,
          Text(AppLocalizations.of(context).delete),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Navigate after a short delay
        Timer(const Duration(milliseconds: 1100), () {
          if (mounted) {
            context.goNamed(AppRoute.home.name);
          }
        });
      }
    } catch (error) {
      if (mounted) {
        _showSnackBar(context, context.loc.failedToDeleteKhatma);
      }
    }
  }

  void _showStyleSelector(BuildContext context, Khatma khatma) {
    _showModal(
      context,
      KhatmaStyleSelector(
        style: khatma.style,
        onChanged: (value) => ref.read(khatmaFormProvider.notifier).update(
              khatma.copyWith(theme: value),
            ),
      ),
      AppLocalizations.of(context).khatmaStyle,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showModal(BuildContext context, Widget child, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => ModalBottomSheet(
        title: title,
        child: child,
      ),
    );
  }
}

// Extension moved to separate file would be better
extension KhatmaFormProviderExtension on WidgetRef {
  void updateKhatma(Khatma khatma) {
    read(khatmaFormProvider.notifier).update(khatma);
  }
}
