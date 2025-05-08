import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/extensions/async_value_ui.dart';
import 'package:khatma/src/features/authentication/presentation/login/email_password_login_controller.dart';
import 'package:khatma/src/features/authentication/presentation/login/email_password_login_form_type.dart';
import 'package:khatma/src/features/authentication/presentation/login/email_password_login_validators.dart';
import 'package:khatma/src/features/authentication/presentation/login/string_validators.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/google_button.dart';
import 'package:khatma/src/i18n/string_hardcoded.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/components/responsive_scrollable_card.dart';
import 'package:khatma_ui/constants/app_sizes.dart'; // Assuming you have GoRouter set up

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
    this.onSuccess,
    this.formType = EmailPasswordSignInFormType.signIn,
  });

  final VoidCallback? onSuccess;
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  var _submitted = false;
  late var _formType = widget.formType;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(emailPasswordSignInControllerProvider.notifier);
      final success = await controller.submit(
        email: email,
        password: password,
        formType: _formType,
      );
      if (success) {
        widget.onSuccess?.call();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(emailPasswordSignInControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
        centerTitle: true,
      ),
      floatingActionButton: const FooterLinks(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: ResponsiveScrollableCard(
          child: FocusScope(
            node: _node,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gapH64,
                  CircleAvatar(
                    backgroundColor: Theme.of(context).disabledColor,
                    radius: 50,
                    backgroundImage: AssetImage('assets/khatma.png'),
                  ),
                  gapH64,
                  // Login field
                  TextFormField(
                    key: Key('email'),
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email'.hardcoded,
                      hintText: 'test@test.com'.hardcoded,
                      enabled: !state.isLoading,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        !_submitted ? null : emailErrorText(email ?? ''),
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.light,
                    onEditingComplete: () => _emailEditingComplete(),
                    inputFormatters: <TextInputFormatter>[
                      ValidatorInputFormatter(
                          editingValidator: EmailEditingRegexValidator()),
                    ],
                  ),
                  gapH16,

                  // Password field
                  TextFormField(
                    key: Key('password'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: _formType.passwordLabelText,
                      enabled: !state.isLoading,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) => !_submitted
                        ? null
                        : passwordErrorText(password ?? '', _formType),
                    obscureText: _obscurePassword,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    keyboardAppearance: Brightness.light,
                    onEditingComplete: () => _passwordEditingComplete(),
                  ),
                  gapH8,
                  // Forgot password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.goNamed(AppRoute.forgotPassword.name);
                      },
                      child: const Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  gapH16,
                  // Login button
                  ElevatedButton(
                    onPressed: () => _submit(),
                    child: const Text('Se connecter'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Pas encore de compte? ",
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          context.goNamed(AppRoute.register.name);
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  gapH24,

                  // Divider with "Or" in the center
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Ou',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  gapH24,
                  GoogleButton(
                    onPressed: () {
                      // Handle Google login logic
                    },
                    label: 'Se connecter avec Google',
                  ),
                  gapH24,

                  // Google login button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google login logic
                    },
                    icon: const Icon(Icons.masks_rounded),
                    label: const Text('Continuer en tant qu\'invité'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.grey.shade400,
                    ),
                  ),
                  gapH24,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
