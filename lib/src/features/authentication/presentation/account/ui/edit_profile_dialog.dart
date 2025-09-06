import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/presentation/validators/auth_validators.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/text_input_field.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/modern_modal_sheet.dart';
import 'package:khatma_ui/khatma_ui.dart';
import '../logic/account_controller.dart';

class EditProfileDialog {
  static void show(BuildContext context, WidgetRef ref, String? currentValue) {
    final nameController = TextEditingController(text: currentValue);
    final formKey = GlobalKey<FormState>();
    final isLoadingNotifier = ValueNotifier<bool>(false);
    final errorNotifier = ValueNotifier<String?>(null);

    // Clear error when user types
    nameController.addListener(() {
      if (errorNotifier.value != null) {
        errorNotifier.value = null;
      }
    });

    ModernBottomSheet.show(
      context: context,
      title: context.loc.editProfile,
      subtitle: context.loc.changeDisplayNameSubtitle,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInputField(
              controller: nameController,
              submitted: true,
              hintText: context.loc.fullNameOrNicknameHint,
              labelText: context.loc.fullNameOrNickname,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => nameController.clear(),
              ),
              validator: AuthValidators.validateName,
              maxLength: 50,
            ),
            ValueListenableBuilder<String?>(
              valueListenable: errorNotifier,
              builder: (context, error, _) {
                if (error == null) return const SizedBox.shrink();
                return Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 16,
                        color: context.colorScheme.onErrorContainer,
                      ),
                      gapW8,
                      Expanded(
                        child: Text(
                          error,
                          style: TextStyle(
                            color: context.colorScheme.onErrorContainer,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, _) {
            return ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () => _updateProfile(
                        context,
                        ref,
                        nameController.text,
                        formKey,
                        isLoadingNotifier,
                        errorNotifier,
                        currentValue,
                      ),
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(context.loc.save),
            );
          },
        ),
      ],
    );
  }

  static Future<void> _updateProfile(
    BuildContext context,
    WidgetRef ref,
    String displayName,
    GlobalKey<FormState> formKey,
    ValueNotifier<bool> isLoadingNotifier,
    ValueNotifier<String?> errorNotifier,
    String? currentValue,
  ) async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    final trimmedName = displayName.trim();

    // Check if no changes made
    if (trimmedName == (currentValue ?? '').trim()) {
      Navigator.of(context).pop();
      return;
    }

    // Start loading
    isLoadingNotifier.value = true;
    errorNotifier.value = null;

    try {
      final controller = ref.read(profileControllerProvider.notifier);
      final result = await controller.updateDisplayName(trimmedName);

      if (!context.mounted) return;

      result.handleUI(
        context,
        onSuccess: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.loc.profileUpdatedSuccessfully),
              backgroundColor: context.successColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
        errorNotifier.value = context.loc.errorGeneralUnknown;
      }
    } finally {
      if (context.mounted) {
        isLoadingNotifier.value = false;
      }
    }
  }
}
