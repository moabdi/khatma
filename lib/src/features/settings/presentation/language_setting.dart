import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/i18n/local_provider.dart';
import 'package:khatma_ui/constants/app_dividers.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class LanguageSettings extends ConsumerWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  LanguageOption(
                    title: 'العربية',
                    subTitle: 'Arabic',
                    code: 'ar',
                  ),
                  dividerH0_5T1,
                  LanguageOption(
                    title: 'English',
                    subTitle: 'Default',
                    code: 'en',
                  ),
                  dividerH0_5T1,
                  LanguageOption(
                    title: 'Français',
                    subTitle: 'Frensh',
                    code: 'fr',
                  ),
                  dividerH0_5T1,
                  LanguageOption(
                    title: 'Español',
                    subTitle: 'Espagnol',
                    code: 'es',
                  ),
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
}

class LanguageOption extends ConsumerWidget {
  const LanguageOption({
    super.key,
    required this.title,
    required this.subTitle,
    required this.code,
  });

  final String title;
  final String subTitle;
  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider).languageCode;
    final isSelected = selectedLocale == code;
    final color = Theme.of(context).colorScheme.primary;

    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: isSelected ? Icon(Icons.check_circle, color: color) : null,
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(code);
      },
      tileColor: isSelected ? Colors.green.withAlpha(10) : null,
    );
  }
}
