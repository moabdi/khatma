import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:khatma/src/core/app_dialog.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/personal/application/khatmat_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_data.dart';
import 'package:khatma/src/features/khatma/presentation/form/logic/khatma_form_provider.dart';
import 'package:khatma/src/features/khatma/presentation/form/shared_config_screen.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/date_field.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_avatar.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/repeat_enabler_tile.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/style_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/type_selector.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/unit_selector.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import 'package:khatma/src/constants/snack_bars.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/widgets/empty_placeholder_widget.dart';
import 'package:khatma_ui/components/modal_bottom_sheet.dart';
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
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final FocusScopeNode _focusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusScopeNode();

    // If editing, ensure the form is initialized
    if (widget.khatmaId != null) {
      final formData = ref.read(khatmaFormProvider);
      // If the form doesn't match the khatma we're editing, it means
      // the route didn't initialize it properly, so do it here
      if (formData.id != widget.khatmaId) {
        // This is a fallback - try to load from the provider
        // In practice, the route should have already done this
        print('Warning: Form not initialized in route, initializing in initState');
      }
    }

    // Initialize controllers with current khatma data
    final khatma = ref.read(khatmaFormProvider);
    _nameController = TextEditingController(text: khatma.name);
    _descController = TextEditingController(text: khatma.description);
    _startDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(khatma.startDate),
    );
    _endDateController = TextEditingController(
      text: khatma.endDate != null
          ? DateFormat('dd/MM/yyyy').format(khatma.endDate!)
          : '',
    );

    // Listen to controller changes and update the provider
    _nameController.addListener(_onTextFieldChanged);
    _descController.addListener(_onTextFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextFieldChanged() {
    final formData = ref.read(khatmaFormProvider);
    ref.read(khatmaFormProvider.notifier).update(
          formData.copyWith(
            name: _nameController.text,
            description: _descController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(khatmaFormProvider);
    final isEditing = widget.khatmaId != null;

    return Scaffold(
      appBar: _buildAppBar(context, isEditing),
      body: _buildBody(context, formData),
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

  Widget _buildBody(BuildContext context, KhatmaFormData formData) {
    // Check if we're editing a khatma that doesn't match the current ID
    if (widget.khatmaId != null && formData.id != widget.khatmaId) {
      return const EmptyPlaceholderWidget(message: 'Khatma not found');
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FocusScope(
                node: _focusNode,
                child: _buildFormContent(context, formData),
              ),
            ),
          ),
          _buildBottomButtons(context, formData),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context, KhatmaFormData formData) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH24,
            KhatmaAvatarMaterial(
              khatma: formData,
              onTap: () => _showStyleSelector(context, formData),
            ),
            gapH16,
            _buildNameField(context),
            gapH16,
            _buildDescriptionField(context),
            gapH16,
            _buildTypeSelector(context, formData),
            gapH16,
            _buildSplitUnitSelector(context, formData),
            gapH16,
            _buildRepeatToggle(formData),
            gapH24,
            _buildStartDateField(context),
            gapH16,
            _buildEndDateField(context),
            gapH24,
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, KhatmaFormData formData) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(AppLocalizations.of(context).save),
              onPressed: () => _handleSave(context),
            ),
          ),
          gapH16,
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
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

  Widget _buildDescriptionField(BuildContext context) {
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

  Widget _buildStartDateField(BuildContext context) {
    return DateField(
      controller: _startDateController,
      labelText: 'Start Date',
      isRequired: true,
      onDateSelected: (date) {
        if (date != null) {
          final formData = ref.read(khatmaFormProvider);
          ref.read(khatmaFormProvider.notifier).update(
                formData.copyWith(startDate: date),
              );
        }
      },
    );
  }

  Widget _buildEndDateField(BuildContext context) {
    final startDate = _parseDate(_startDateController.text) ?? DateTime.now();

    return DateField(
      controller: _endDateController,
      labelText: 'End Date (Optional)',
      isRequired: false,
      firstDate: startDate,
      onDateSelected: (date) {
        final formData = ref.read(khatmaFormProvider);
        ref.read(khatmaFormProvider.notifier).update(
              formData.copyWith(endDate: date),
            );
      },
    );
  }

  DateTime? _parseDate(String dateString) {
    if (dateString.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  Widget _buildTypeSelector(BuildContext context, KhatmaFormData formData) {
    // Type cannot be changed when editing
    final canChangeType = !formData.isEditing;

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
        title: Text(AppLocalizations.of(context).khatmaType),
        subtitle: Text(
          formData.type.name,
        ),
        enabled: canChangeType,
        onTap: canChangeType ? () => _handleTypeTap(context, formData) : null,
      ),
    );
  }

  Widget _buildSplitUnitSelector(BuildContext context, KhatmaFormData formData) {
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
          AppLocalizations.of(context).khatmaSplitUnitDesc(formData.unit.name),
        ),
        onTap: () => _handleSplitUnitTap(context, formData),
      ),
    );
  }

  void _handleTypeTap(BuildContext context, KhatmaFormData formData) {
    _showModal(
      context,
      TypeSelector(
        type: formData.type,
        onSelect: (value) => ref
            .read(khatmaFormProvider.notifier)
            .update(formData.copyWith(type: value)),
      ),
      AppLocalizations.of(context).khatmaType,
    );
  }

  void _handleSplitUnitTap(BuildContext context, KhatmaFormData formData) {
    // Only prevent changing unit if editing an existing khatma that has started
    if (formData.isEditing && formData.isStarted) {
      _showSnackBar(context, context.loc.cannotUpdateKhatmaWhileStarted);
      return;
    }

    _showModal(
      context,
      UnitSelector(
        unit: formData.unit,
        onSelect: (value) => ref
            .read(khatmaFormProvider.notifier)
            .update(formData.copyWith(unit: value)),
      ),
      AppLocalizations.of(context).splitUnit,
    );
  }

  Widget _buildRepeatToggle(KhatmaFormData formData) {
    return Card(
      child: RepeatKhatmaTile(
        enabled: formData.repeat,
        onChanged: (enabled) => ref.read(khatmaFormProvider.notifier).update(
              formData.copyWith(repeat: enabled),
            ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    final formData = ref.watch(khatmaFormProvider);
    if (formData.id == null) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _handleDelete(context),
        icon: Icon(Icons.delete),
        label: Text(AppLocalizations.of(context).delete),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
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

  Future<void> _handleSave(BuildContext context) async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final isEditing = widget.khatmaId != null;
      final formData = ref.read(khatmaFormProvider);

      if (mounted) {
        if (isEditing) {
          // If editing, save and go back to the read screen
          await ref.read(khatmaFormProvider.notifier).save();
          Navigator.of(context).pop();
        } else {
          // If creating new, check if it's a shared or hifz khatma
          if (formData.type == KhatmaType.shared) {
            // Navigate to shared config screen without saving yet
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SharedKhatmaConfigScreen(),
              ),
            );
          } else if (formData.type == KhatmaType.hifz) {
            // TODO: Navigate to hifz config screen when implemented
            await ref.read(khatmaFormProvider.notifier).save();
            context.go('/khatma');
          } else {
            // For personal khatma, save and navigate directly
            await ref.read(khatmaFormProvider.notifier).save();
            final savedKhatma = ref.read(khatmaNotifierProvider).selectedKhatma;
            if (savedKhatma != null && savedKhatma.id != null) {
              context.go('/khatma/personal/${savedKhatma.id}');
            } else {
              context.go('/khatma');
            }
          }
        }
      }
    } catch (error) {
      print(error);
      if (mounted) {
        _showSnackBar(context, context.loc.failedToSaveKhatma);
      }
    }
  }

  Future<void> _handleDelete(BuildContext context) async {
    final formData = ref.read(khatmaFormProvider);
    if (formData.id == null) return;

    try {
      final shouldDelete = await AppDialog.showDelete(
        context,
        itemName: formData.name,
      );

      if (!shouldDelete!) return;

      await ref.read(khatmaFormProvider.notifier).delete();

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

  void _showStyleSelector(BuildContext context, KhatmaFormData formData) {
    _showModal(
      context,
      KhatmaStyleSelector(
        style: formData.theme,
        onChanged: (value) => ref.read(khatmaFormProvider.notifier).update(
              formData.copyWith(theme: value),
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
  void updateKhatma(KhatmaFormData formData) {
    read(khatmaFormProvider.notifier).update(formData);
  }
}
