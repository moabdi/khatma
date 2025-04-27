import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  // Variable to track the selected theme
  String _selectedTheme = 'system'; // Default to system theme

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionner le thème'),
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
                // Avatar and theme icon at the top
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  radius: 40,
                  child: Icon(
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
                _buildThemeOption(context, 'Clair', 'light'),
                const Divider(),
                _buildThemeOption(context, 'Sombre', 'dark'),
                const Divider(),
                _buildThemeOption(context, 'Système', 'system'),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
      BuildContext context, String themeName, String themeValue) {
    final isSelected = _selectedTheme == themeValue;

    return ListTile(
      title: Text(themeName),
      leading: isSelected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () {
        setState(() {
          _selectedTheme = themeValue;
        });
        _applyTheme(context, _selectedTheme);
      },
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
    );
  }

  void _applyTheme(BuildContext context, String theme) {
    // Set the theme mode based on the user's choice
    ThemeMode themeMode;
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system; // Default to system theme
    }
  }
}
