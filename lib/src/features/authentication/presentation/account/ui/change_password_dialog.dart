import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/dynamic_password_requierements.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/password_field.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/modern_modal_sheet.dart';
import 'package:khatma_ui/khatma_ui.dart';
import '../logic/account_controller.dart';
import '../../validators/auth_validators.dart';

class ChangePasswordDialog {
  // Keep the static show method for easy access
  static void show(BuildContext context, WidgetRef ref) {
    ModernBottomSheet.show(
      context: context,
      title: context.loc.changePassword,
      subtitle: context.loc.changePasswordSubtitle,
      content: ChangePasswordForm(),
    );
  }
}

// Extract the form into a separate widget that can use mixins
class ChangePasswordForm extends ConsumerStatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  ConsumerState<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends ConsumerState<ChangePasswordForm>
    with RegistrationValidatorsMixin {
  // Your mixin here

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Current Password Field
          PasswordField(
            controller: currentPasswordController,
            isLoading: _isLoading,
            submitted: true,
            obscurePassword: _obscureCurrentPassword,
            onObscureToggle: () {
              setState(() {
                _obscureCurrentPassword = !_obscureCurrentPassword;
              });
            },
            validator: validateCurrentPassword,
            labelText: context.loc.currentPassword,
            hintText: context.loc.yourPassword,
            textInputAction: TextInputAction.next,
          ),
          gapH16,

          // New Password Field
          PasswordField(
            controller: newPasswordController,
            isLoading: _isLoading,
            submitted: true,
            obscurePassword: _obscureNewPassword,
            onObscureToggle: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
            validator: validatePassword,
            labelText: context.loc.newPassword,
            hintText: context.loc.newPassword,
            textInputAction: TextInputAction.next,
          ),
          gapH16,

          // Confirm New Password Field
          ValueListenableBuilder<TextEditingValue>(
              valueListenable: confirmPasswordController,
              builder: (context, value, child) {
                return AnimatedPasswordField(
                  controller: confirmPasswordController,
                  isLoading: _isLoading,
                  submitted: true,
                  obscurePassword: _obscureConfirmPassword,
                  confirmPassword: newPasswordController.text,
                  onObscureToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  confirmValidator: validateConfirmPassword,
                  labelText: context.loc.confirmNewPassword,
                  hintText: context.loc.confirmNewPassword,
                  textInputAction: TextInputAction.done,
                  onSubmit: _handleChangePassword,
                );
              }),
          gapH8,

          // Password Requirements
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: newPasswordController,
            builder: (context, value, child) {
              return DynamicPasswordRequirements(
                password: value.text,
                showTitle: false,
              );
            },
          ),
          gapH24,
          // Action Buttons
          ElevatedButton(
            onPressed: _isLoading ? null : _handleChangePassword,
            child: _isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(context.loc.change),
          ),
        ],
      ),
    );
  }

  Future<void> _handleChangePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final controller = ref.read(passwordControllerProvider.notifier);
      final result = await controller.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );

      if (!mounted) return;

      result.handleUI(
        context,
        onSuccess: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.loc.passwordUpdatedSuccessfully),
              backgroundColor: context.successColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
