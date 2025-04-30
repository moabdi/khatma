import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

import '../widgets/back_to_login.dart';
import '../widgets/footer_links.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
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
                  backgroundImage: const AssetImage('assets/khatma.png'),
                ),
                gapH64,

                // Name field
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Nom & Prénom ou Pseudonyme',
                    hintText: 'Entrez votre nom complet ou un pseudo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Email/Username field
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Identifiant ou Email',
                    hintText: 'Entrez votre identifiant ou email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password field
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    hintText: 'Confirmez votre mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Register button
                ElevatedButton(
                  onPressed: () {
                    // Handle register logic
                  },
                  child: const Text('Créer un compte'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                gapH24,
                BackToLogin(),
                gapH24,
                FooterLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
