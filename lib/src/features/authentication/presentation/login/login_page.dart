import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/presentation/login/email_password_login_screen.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/google_button.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/components/responsive_scrollable_card.dart';
import 'package:khatma_ui/constants/app_sizes.dart'; // Assuming you have GoRouter set up

class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
    this.onSuccess,
  });

  final VoidCallback? onSuccess;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
        centerTitle: true,
      ),
      floatingActionButton: const FooterLinks(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: ResponsiveScrollableCard(
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
              EmailPasswordLoginScreen(
                onSuccess: () => context.goNamed(AppRoute.home.name),
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
    );
  }
}
