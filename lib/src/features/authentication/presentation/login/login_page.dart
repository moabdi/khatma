import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/application/login_manager.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/error/app_error_handler.dart';
import 'package:khatma/src/themes/theme.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

import '../widgets/app_logo.dart';
import '../widgets/welcome_section.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/action_button.dart';
import '../widgets/social_sign_in_section.dart';

import '../validators/auth_validators.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with LoginValidatorsMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _submitted = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    ref.read(loginManagerProvider.notifier).getSavedEmail().then((savedEmail) {
      _emailController.text = savedEmail ?? '';
    });
    ref
        .read(loginManagerProvider.notifier)
        .isRememberMeEnabled()
        .then((rememberMe) {
      setState(() {
        _rememberMe = rememberMe;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginManagerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.signIn),
        centerTitle: true,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppLogo(),
                    gapH16,
                    const WelcomeSection(),
                    gapH16,

                    // Email Field
                    EmailField(
                      controller: _emailController,
                      isLoading: isLoading,
                      submitted: _submitted,
                      validator: validateEmail,
                    ),
                    gapH20,

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
                      onSubmit: _handleEmailPasswordLogin,
                      validator: validatePassword,
                    ),
                    gapH8,
                    // Remember Me and Forgot Password
                    ListTile(
                      tileColor: Colors.transparent,
                      horizontalTitleGap: 0,
                      leading: Checkbox(
                        value: _rememberMe,
                        onChanged: isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                      ),
                      title: Text(
                        context.loc.rememberMe,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context
                              .theme.listTileTheme.subtitleTextStyle?.color,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      trailing: TextButton(
                        onPressed: isLoading
                            ? null
                            : () =>
                                context.goNamed(AppRoute.forgotPassword.name),
                        child: Text(context.loc.forgotPassword),
                      ),
                    ),
                    gapH20,
                    // Action Button
                    ActionButton.primary(
                      text: context.loc.signIn,
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _handleEmailPasswordLogin,
                    ),
                    gapH20,
                    SocialDivider(),
                    gapH20,
                    OutlinedButton.icon(
                      icon: Icon(Icons.person_3),
                      onPressed: () => context.goNamed(AppRoute.register.name),
                      label: Text(context.loc.createAccount),
                    ),
                    gapH16,
                    SocialSignInSection(
                      isLoading: isLoading,
                      onGoogleSignIn: _handleGoogleSignIn,
                      onAnonymousSignIn: _handleAnonymousSignIn,
                      showAnonymous:
                          ref.read(authStateChangesProvider).value == null,
                    ),
                    gapH16,

                    // Footer Links
                    const FooterLinks(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleEmailPasswordLogin() async {
    setState(() => _submitted = true);

    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.submitEmailPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      rememberMe: _rememberMe,
    );

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () => context.goNamed(AppRoute.profil.name),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.signInWithGoogle();

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () => context.goNamed(AppRoute.profil.name),
    );
  }

  Future<void> _handleAnonymousSignIn() async {
    final controller = ref.read(loginManagerProvider.notifier);
    final result = await controller.signInAnonymously();

    if (!mounted) return;

    result.handleUI(
      context,
      onSuccess: () => context.goNamed(AppRoute.profil.name),
    );
  }
}
