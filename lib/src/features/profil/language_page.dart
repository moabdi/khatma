import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLocale = 'fr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner la langue'),
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
                const SizedBox(height: 32),
                const Text(
                  "Sélectionnez la langue que vous souhaitez utiliser",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Arabic Option
                _buildLanguageOption(context, 'العربية 🇸🇦', 'ar'),
                const SizedBox(height: 16),
                // English Option
                _buildLanguageOption(context, 'English 🇬🇧', 'en'),
                const SizedBox(height: 16),
                // French Option
                _buildLanguageOption(context, 'Français 🇫🇷', 'fr'),
                const SizedBox(height: 16),
                // Spanish Option
                _buildLanguageOption(context, 'Español 🇪🇸', 'es'),
                const SizedBox(height: 32),
                // Footer text with copyright and links
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageName,
    String localeCode,
  ) {
    final isSelected = _selectedLocale == localeCode;

    return ListTile(
      title: Text(languageName),
      leading: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () {
        setState(() {
          _selectedLocale = localeCode;
        });

        final locale = Locale(_selectedLocale);
        // No auto pop after selection
      },
      tileColor: Theme.of(context).primaryColor.withOpacity(0.1),
    );
  }
}
