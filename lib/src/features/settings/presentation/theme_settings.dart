import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/themes/theme_provider.dart';

class ThemePage extends ConsumerWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildAvatar(context),
              const SizedBox(height: 32),
              _buildInstructionText(),
              const SizedBox(height: 24),
              _buildThemeOption(
                context,
                ref,
                icon: Icons.light_mode,
                themeName: 'Clair',
                themeMode: ThemeMode.light,
                currentThemeMode: themeMode,
                iconColor: Colors.orangeAccent,
              ),
              const Divider(),
              _buildThemeOption(
                context,
                ref,
                icon: Icons.dark_mode,
                themeName: 'Sombre',
                themeMode: ThemeMode.dark,
                currentThemeMode: themeMode,
                iconColor: Colors.deepPurple,
              ),
              const Divider(),
              _buildThemeOption(
                context,
                ref,
                icon: Icons.settings_suggest, // Updated icon for system
                themeName: 'Système',
                themeMode: ThemeMode.system,
                currentThemeMode: themeMode,
                iconColor: Colors.blueGrey,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Thème'),
      centerTitle: true,
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      radius: 40,
      child: const Icon(
        Icons.brightness_6,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  Widget _buildInstructionText() {
    return const Text(
      "Sélectionnez le thème que vous souhaitez utiliser",
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String themeName,
    required ThemeMode themeMode,
    required ThemeMode currentThemeMode,
    required Color iconColor,
  }) {
    final isSelected = currentThemeMode == themeMode;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(themeName),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      onTap: () => ref.read(themeProvider.notifier).setThemeMode(themeMode),
    );
  }
}
