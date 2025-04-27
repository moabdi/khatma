import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/profil/about_us.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

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
                // Avatar and language icon at the top
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(.5),
                  radius: 40,
                  child: const Icon(
                    Icons.language,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                gapH32,
                const Text(
                  "Sélectionnez la langue que vous souhaitez utiliser",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                gapH24,
                _buildLanguageOption(context, 'العربية 🇸🇦', 'ar'),
                const Divider(),
                _buildLanguageOption(context, 'English 🇬🇧', 'en'),
                const Divider(),
                _buildLanguageOption(context, 'Français 🇫🇷', 'fr'),
                const Divider(),
                _buildLanguageOption(context, 'Español 🇪🇸', 'es'),
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
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
    );
  }
}
