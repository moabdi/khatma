import 'package:flutter/material.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

import '../widgets/back_to_login.dart'; // Assuming you have GoRouter set up

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récupérer le mot de passe'),
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
                  "Entrez votre email pour récupérer votre mot de passe",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Email input
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Entrez votre email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    // Handle password recovery logic (e.g., send email)
                  },
                  child: const Text('Récupérer le mot de passe'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                gapH24,
                BackToLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
