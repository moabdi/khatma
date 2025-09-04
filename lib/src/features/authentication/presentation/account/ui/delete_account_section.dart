import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/features/authentication/presentation/validators/auth_validators.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/password_field.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/components/modern_modal_sheet.dart';
import 'package:khatma_ui/khatma_ui.dart';
import '../logic/account_controller.dart';
import '../ui/settings_tile.dart';

class DeleteAccountSection extends ConsumerWidget {
  DeleteAccountSection(this.user, {super.key});
  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delete Account
          SettingsTile(
            icon: Icons.heart_broken,
            leadingColor: Colors.red.shade700,
            title: context.loc.deleteAccount,
            subtitle: context.loc.permanentlyDeleteAccount,
            titleColor: Colors.red.shade700,
            //  subtitleColor: Colors.red.shade600,
            onTap: () => _showDeleteAccountDialog(context, ref, user),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(
      BuildContext context, WidgetRef ref, AppUser user) {
    ModernBottomSheet.show(
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
      title: context.loc.deleteAccount,
      subtitle: context.loc.deleteAccountWarning,
      content: _DeleteAccountSheet(ref: ref, user: user),
    );
  }
}

class _DeleteAccountSheet extends ConsumerStatefulWidget {
  final WidgetRef ref;
  final AppUser user;

  const _DeleteAccountSheet({required this.ref, required this.user});

  @override
  ConsumerState<_DeleteAccountSheet> createState() =>
      _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends ConsumerState<_DeleteAccountSheet>
    with LoginValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isDeleting = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requiresPassword = widget.user.isSignedInWithEmailPassword;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (requiresPassword) ...[
              // Password Field
              PasswordField(
                controller: passwordController,
                labelText: context.loc.confirmWithPassword,
                hintText: context.loc.yourPassword,
                submitted: true,
                obscurePassword: _obscurePassword,
                onObscureToggle: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                validator: validatePassword,
              ),
              gapH24,
            ],

            // Actions
            ElevatedButton(
              onPressed:
                  _isDeleting ? null : () => _deleteAccount(requiresPassword),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.error,
                foregroundColor: Colors.white,
              ),
              child: _isDeleting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(context.loc.delete),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAccount(bool requiresPassword) async {
    // Validate form first
    if (requiresPassword && !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isDeleting = true;
    });

    try {
      final controller =
          widget.ref.read(accountDeletionControllerProvider.notifier);
      final result = await controller.deleteAccount(
        password: passwordController.text,
      );

      if (!mounted) return;

      result.handleUI(
        context,
        onSuccess: () {
          Navigator.of(context).pop();
          context.goNamed(AppRoute.home.name);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.loc.accountDeletedSuccessfully),
              backgroundColor: context.errorColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }
}
