import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/back_to_login.dart';
import 'package:khatma/src/features/authentication/presentation/widgets/footer_links.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récupérer le mot de passe'),
        centerTitle: true,
      ),
      floatingActionButton: const FooterLinks(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH48,
                CircleAvatar(
                  backgroundColor: Theme.of(context).disabledColor,
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/khatma.png'), // Ton logo ici
                ),
                gapH48,
                Text(
                  "Entrez votre email pour récupérer votre mot de passe",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                gapH24,
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Entrez votre email',
                    border: OutlineInputBorder(),
                  ),
                ),
                gapH24,
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
