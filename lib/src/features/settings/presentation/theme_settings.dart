import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/common/utils/common.dart';
import 'package:khatma/src/themes/theme_provider.dart';
import 'package:khatma_ui/constants/app_dividers.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ThemePage extends ConsumerWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).theme)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              gapH32,
              Text(
                AppLocalizations.of(context).chooseTheme,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              gapH12,
              Card(
                child: Column(
                  children: [
                    ThemeOption(
                      themeMode: ThemeMode.light,
                      icon: Icons.light_mode,
                      iconColor: Colors.orangeAccent,
                      currentThemeMode: currentThemeMode,
                    ),
                    dividerH1T0_5,
                    ThemeOption(
                      themeMode: ThemeMode.dark,
                      icon: Icons.dark_mode,
                      iconColor: Colors.deepPurple,
                      currentThemeMode: currentThemeMode,
                    ),
                    dividerH1T0_5,
                    ThemeOption(
                      themeMode: ThemeMode.system,
                      icon: Icons.settings_suggest,
                      iconColor: Colors.blueGrey,
                      currentThemeMode: currentThemeMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeOption extends ConsumerWidget {
  const ThemeOption({
    super.key,
    required this.themeMode,
    required this.icon,
    required this.iconColor,
    required this.currentThemeMode,
  });

  final ThemeMode themeMode;
  final IconData icon;
  final Color iconColor;
  final ThemeMode currentThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = currentThemeMode == themeMode;
    final color = Theme.of(context).colorScheme.primary;

    return ListTile(
      minTileHeight: 50,
      leading: Icon(icon, color: iconColor),
      title: Text(AppLocalizations.of(context).themeMode(themeMode.name)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : null,
      tileColor: isSelected ? color.withAlpha(25) : null,
      onTap: () {
        ref.read(themeProvider.notifier).setThemeMode(themeMode);
      },
    );
  }
}
