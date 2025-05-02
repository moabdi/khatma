import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/utils/common.dart';
import 'package:khatma/src/themes/theme_provider.dart';
import 'package:khatma_ui/constants/app_dividers.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ThemeSettings extends ConsumerWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    ),
                    dividerH1T0_5,
                    ThemeOption(
                      themeMode: ThemeMode.dark,
                      icon: Icons.dark_mode,
                      iconColor: Colors.deepPurple,
                    ),
                    dividerH1T0_5,
                    ThemeOption(
                      themeMode: ThemeMode.system,
                      icon: Icons.settings_suggest,
                      iconColor: Colors.blueGrey,
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
  });

  final ThemeMode themeMode;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);
    final isSelected = currentThemeMode == themeMode;
    final color = Theme.of(context).colorScheme.primary;

    return ListTile(
      minTileHeight: 50,
      leading: Icon(icon, color: iconColor),
      title: Text(AppLocalizations.of(context).themeMode(themeMode.name)),
      trailing: isSelected ? Icon(Icons.check_circle, color: color) : null,
      tileColor: isSelected ? color.withAlpha(25) : null,
      onTap: () {
        ref.read(themeProvider.notifier).setThemeMode(themeMode);
      },
    );
  }
}
