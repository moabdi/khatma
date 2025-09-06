import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/application/login_manager.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/email_field.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/password_field.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/text_input_field.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import '../validators/auth_validators.dart';
import '../widgets/back_to_login.dart';
import '../widgets/dynamic_password_requierements.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage>
    with RegistrationValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _submitted = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    // Set submitted flag
    _submitted = true;

    // Force immediate rebuild before validation
    setState(() {});

    // Wait for the widget to rebuild
    await Future.delayed(Duration.zero);

    // Always set submitted to trigger field validation display
    setState(() => _submitted = true);
    // If validation fails, just return (no snackbar since field errors are now visible)
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check terms acceptance
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.loc.mustAcceptTerms),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    // Validate form fields
    final isFormValid = canSubmitForm(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      acceptedTerms: _acceptedTerms,
    );

    final isFormKeyValid = _formKey.currentState!.validate();

    // If validation fails, just return (no snackbar since field errors are now visible)
    if (!isFormValid || !isFormKeyValid) {
      return;
    }

    // All validations passed, proceed with registration
    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.createAccount(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.accountCreatedSuccessfully),
            backgroundColor: context.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.goNamed(AppRoute.home.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(loginManagerProvider);
    final authState = ref.watch(loginManagerProvider);
    final isLoading = registerState.isLoading || authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.createAccount),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH16,
                    AppLogo(),
                    gapH12,
                    Text(
                      context.loc.joinUs,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    gapH8,
                    Text(
                      context.loc.createAccountToStart,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    gapH24,
                    TextInputField(
                      controller: _nameController,
                      isLoading: isLoading,
                      submitted: _submitted,
                      hintText: context.loc.fullNameOrNicknameHint,
                      labelText: context.loc.fullNameOrNickname,
                      validator: validateName,
                    ),
                    gapH12,
                    EmailField(
                      controller: _emailController,
                      isLoading: isLoading,
                      submitted: _submitted,
                      validator: validateEmail,
                    ),
                    gapH16,
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
                      onSubmit: _handleRegistration,
                      validator: validatePassword,
                    ),
                    gapH8,
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _passwordController,
                      builder: (context, value, child) {
                        return value.text.isNotEmpty
                            ? PasswordStrengthIndicator(
                                password: value.text,
                                height: 4,
                              )
                            : SizedBox();
                      },
                    ),
                    gapH12,
                    ValueListenableBuilder(
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
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          onSubmit: _handleRegistration,
                          confirmValidator: validateConfirmPassword,
                          confirmPassword: _passwordController.text,
                        );
                      },
                    ),
                    gapH12,
                    _buildAcceptCondition(isLoading, context),
                    gapH24,
                    ElevatedButton(
                      onPressed: isLoading ? null : _handleRegistration,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(context.loc.createMyAccount),
                    ),
                    gapH20,
                    const BackToLogin(),
                    gapH20,
                    // Footer Links
                    const FooterLinks(),
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

  Row _buildAcceptCondition(bool isLoading, BuildContext context) {
    void toggleAcceptance() {
      if (!isLoading) {
        setState(() => _acceptedTerms = !_acceptedTerms);
      }
    }

    final linkStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptedTerms,
          onChanged: isLoading ? null : (value) => toggleAcceptance(),
          visualDensity: VisualDensity.compact,
        ),
        Expanded(
          child: GestureDetector(
            onTap: toggleAcceptance,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.disabledColor,
                  ),
                  children: [
                    TextSpan(text: context.loc.acceptTerms),
                    TextSpan(
                        text: context.loc.termsOfService, style: linkStyle),
                    TextSpan(text: context.loc.andThe),
                    TextSpan(text: context.loc.privacyPolicy, style: linkStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
