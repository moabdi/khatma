import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  backgroundImage: AssetImage(
                      'assets/khatma.png'), // Add your logo in assets
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
                      context.goNamed('forgot_password');
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
                        context.goNamed(
                            'register'); // Navigate to the register page
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

                // Google login button
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Google login logic
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Se connecter avec Google'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                  ),
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

                // Footer text with direct clickable links in copyright
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        const TextSpan(text: '© Khatma 2025 | '),
                        TextSpan(
                          text: 'Conditions Générales d\'Utilisation',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to CGU screen
                              context.goNamed('terms_and_conditions');
                            },
                        ),
                        const TextSpan(text: ' | '),
                        TextSpan(
                          text: 'Mentions Légales',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Mentions Légales screen
                              context.goNamed('legal_mentions');
                            },
                        ),
                        const TextSpan(text: ' | '),
                        TextSpan(
                          text:
                              'Déclaration relative à la protection des données',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to Data Protection screen
                              context.goNamed('data_protection');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
