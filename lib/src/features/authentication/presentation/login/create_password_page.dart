import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/features/authentication/application/login_manager.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/back_to_login.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/dynamic_password_requierements.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/password_field.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import '../validators/auth_validators.dart';

class CreatePasswordPage extends ConsumerStatefulWidget {
  const CreatePasswordPage({
    super.key,
    required this.resetCode,
  });

  final String resetCode;

  @override
  ConsumerState<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends ConsumerState<CreatePasswordPage>
    with CreatePasswordValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _submitted = false;
  bool _passwordUpdated = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    setState(() => _submitted = true);

    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.confirmPasswordReset(
      widget.resetCode,
      _passwordController.text,
    );

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () {
        setState(() => _passwordUpdated = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.passwordUpdatedSuccessfully),
            backgroundColor: context.successColor,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.goNamed(AppRoute.login.name);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginManagerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.newPassword),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                gapH48,

                // App Logo
                AppLogo(),

                gapH48,

                if (!_passwordUpdated) ...[
                  // Password Reset Form
                  Text(
                    context.loc.createNewPassword,
                    style: context.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),

                  gapH16,

                  Text(
                    context.loc.newPasswordDescription,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.theme.disabledColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  gapH48,

                  _buildForm(isLoading, context),
                ] else ...[
                  // Success State
                  _buildSuccess(context),

                  gapH32,

                  // Go to Login Button
                  BackToLogin(),
                ],

                gapH64, // Extra space for footer
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.green.shade700,
            ),
          ),
          gapH24,
          Text(
            context.loc.passwordUpdated,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
            textAlign: TextAlign.center,
          ),
          gapH16,
          Text(
            context.loc.passwordUpdatedDescription,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.disabledColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          gapH24,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                gapW12,
                Expanded(
                  child: Text(
                    context.loc.redirectingToLogin,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue.shade700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _buildForm(bool isLoading, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Password Field
          PasswordField(
            controller: _passwordController,
            isLoading: isLoading,
            submitted: _submitted,
            obscurePassword: _obscurePassword,
            onObscureToggle: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            onSubmit: _handlePasswordReset,
            validator: validatePassword,
          ),

          gapH16,

          // Confirm Password Field

          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _confirmPasswordController,
            builder: (context, value, child) {
              return AnimatedPasswordField(
                controller: _confirmPasswordController,
                isLoading: isLoading,
                submitted: _submitted,
                obscurePassword: _obscureConfirmPassword,
                labelText: context.loc.confirmPassword,
                hintText: context.loc.confirmWithPassword,
                onObscureToggle: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                onSubmit: _handlePasswordReset,
                validator: validatePassword,
                confirmPassword: _passwordController.text,
              );
            },
          ),
          gapH8,

          // Password Requirements
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _passwordController,
            builder: (context, value, child) {
              return DynamicPasswordRequirements(
                password: value.text,
                showTitle: false,
              );
            },
          ),

          gapH32,

          // Update Password Button
          ElevatedButton(
            onPressed: isLoading ? null : _handlePasswordReset,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(context.loc.updatePassword),
          ),
        ],
      ),
    );
  }
}
