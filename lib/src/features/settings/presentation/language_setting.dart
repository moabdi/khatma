import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/localization/local_provider.dart';
import 'package:khatma_ui/constants/app_dividers.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class LanguageSettings extends ConsumerWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider).languageCode;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).language),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            gapH32,
            Text(
              "Langues suggérées",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gapH24,
            Card(
              child: Column(
                children: [
                  _buildLanguageOption(
                      ref, 'العربية', 'Arabic', 'ar', selectedLocale),
                  dividerH0_5T1,
                  _buildLanguageOption(
                      ref, 'English', 'Default', 'en', selectedLocale),
                  dividerH0_5T1,
                  _buildLanguageOption(
                      ref, 'Français', 'Frensh', 'fr', selectedLocale),
                  dividerH0_5T1,
                  _buildLanguageOption(
                      ref, 'Español', 'Espagnol', 'es', selectedLocale),
                ],
              ),
            ),
            gapH12,
            Text(
              "Khatma est disponible en plusieurs langues. Choisissez la langue de votre choix pour une meilleure expérience.",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    WidgetRef ref,
    String languageName,
    String languageSubName,
    String localeCode,
    String selectedLocale,
  ) {
    final isSelected = selectedLocale == localeCode;

    return ListTile(
      title: Text(languageName),
      subtitle: Text(languageSubName),
      leading: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(localeCode);
      },
      tileColor: isSelected ? Colors.green.withOpacity(0.1) : null,
    );
  }
}
