import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart'; // Assuming you have GoRouter set up

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un nouveau mot de passe'),
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
                const SizedBox(height: 64),
                CircleAvatar(
                  backgroundColor: Theme.of(context).disabledColor,
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/khatma.png'), // Ton logo ici
                ),
                const SizedBox(height: 32),
                const Text(
                  "Créez un nouveau mot de passe",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // New Password input
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nouveau mot de passe',
                    hintText: 'Entrez votre nouveau mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Confirm Password input
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    hintText: 'Confirmez votre nouveau mot de passe',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    // Handle password creation logic (e.g., save the new password)
                  },
                  child: const Text('Créer le mot de passe'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 24),
                // Back to login
                TextButton(
                  onPressed: () {
                    context
                        .goNamed(AppRoute.login.name); // Return to login page
                  },
                  child: const Text(
                    'Retour à la page de connexion',
                    style: TextStyle(color: Colors.blue),
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
