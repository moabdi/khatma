import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Assuming you have GoRouter set up

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner la langue'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildLanguageOption(context, 'Français 🇫🇷', 'fr'),
          const Divider(),
          _buildLanguageOption(context, 'English 🇬🇧', 'en'),
          const Divider(),
          _buildLanguageOption(context, 'العربية 🇸🇦', 'ar'),
          const Divider(),
          _buildLanguageOption(context, 'Español 🇪🇸', 'es'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String languageName, String localeCode) {
    return ListTile(
      title: Text(languageName),
      onTap: () {
        _changeLanguage(context, localeCode);
      },
    );
  }

  void _changeLanguage(BuildContext context, String localeCode) {
    // Update the app's language when a user taps on a language
    final locale = Locale(localeCode);

    // Example of changing the locale (this assumes you've set up localization in your app)
    //MyApp.setLocale(context, locale);

    // Go back to the previous screen
    Navigator.pop(context);
  }
}
