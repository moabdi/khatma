import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/google_button.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart'; // Assuming you have GoRouter set up

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
        centerTitle: true,
      ),
      floatingActionButton: const FooterLinks(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Identifiant',
                    hintText: 'Entrez votre identifiant ou email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),

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

                const SizedBox(height: 24),

                // Login button
                ElevatedButton(
                  onPressed: () {
                    // Handle login logic
                  },
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

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
