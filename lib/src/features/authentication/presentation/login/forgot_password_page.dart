import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/application/login_manager.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/app_logo.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/email_field.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/back_to_login.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';
import '../validators/auth_validators.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage>
    with ForgotPasswordValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _submitted = true;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    setState(() => _submitted = true);

    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.sendPasswordResetEmail(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () {
        setState(() => _emailSent = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.loc.passwordResetEmailSent),
            backgroundColor: context.successColor,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      _emailSent = false;
      _submitted = false;
    });
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginManagerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.forgotPassword),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH32,
                  if (!_emailSent) ...[
                    // App Logo
                    AppLogo(),

                    gapH24,
                    // Initial form
                    Text(
                      context.loc.forgotPasswordTitle,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    gapH16,

                    Text(
                      context.loc.forgotPasswordDescription,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    gapH48,

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          EmailField(
                            controller: _emailController,
                            isLoading: isLoading,
                            submitted: _submitted,
                            validator: validateEmail,
                          ),

                          gapH32,

                          // Send Reset Email Button
                          ElevatedButton(
                            onPressed: isLoading ? null : _handlePasswordReset,
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text(context.loc.sendPasswordResetEmail),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.mark_email_read_outlined,
                                size: 48,
                                color: Colors.green.shade700,
                              ),
                            ),
                            gapH24,
                            Text(
                              context.loc.emailSent,
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            gapH16,
                            Text(
                              context.loc.passwordResetEmailSentDescription,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.theme.disabledColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            gapH8,
                            Text(
                              _emailController.text.trim(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            gapH24,
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.blue.shade700,
                                    size: 24,
                                  ),
                                  gapH8,
                                  Text(
                                    context.loc.checkInboxForPasswordReset,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.blue.shade700,
                                          height: 1.4,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  gapH8,
                                  Text(
                                    context.loc.checkSpamFolder,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.blue.shade600,
                                          fontStyle: FontStyle.italic,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapH32,
                    OutlinedButton.icon(
                      onPressed: isLoading ? null : _resetForm,
                      icon: const Icon(Icons.refresh),
                      label: Text(
                        context.loc.resendEmail,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  gapH32,
                  const BackToLogin(),
                  gapH32,
                  FooterLinks(),
                  gapH64,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
