import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  String _selectedTheme = 'system'; // Default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thème'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  radius: 40,
                  child: const Icon(
                    Icons.brightness_6,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Sélectionnez le thème que vous souhaitez utiliser",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildThemeOption(
                  context,
                  icon: Icons.light_mode,
                  themeName: 'Clair',
                  themeValue: 'light',
                  iconColor: Colors.orangeAccent,
                ),
                const Divider(),
                _buildThemeOption(
                  context,
                  icon: Icons.dark_mode,
                  themeName: 'Sombre',
                  themeValue: 'dark',
                  iconColor: Colors.deepPurple,
                ),
                const Divider(),
                _buildThemeOption(
                  context,
                  icon: Icons.settings_suggest,
                  themeName: 'Système',
                  themeValue: 'system',
                  iconColor: Colors.blueGrey,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required IconData icon,
    required String themeName,
    required String themeValue,
    required Color iconColor,
  }) {
    final isSelected = _selectedTheme == themeValue;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(themeName),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      onTap: () {
        setState(() {
          _selectedTheme = themeValue;
        });
        _applyTheme(context, _selectedTheme);
      },
    );
  }

  void _applyTheme(BuildContext context, String theme) {
    ThemeMode themeMode;
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
    // 🚀 Connect here to your App Theme Controller
  }
}
