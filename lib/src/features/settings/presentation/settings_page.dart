import 'package:flutter/material.dart';
import 'package:khatma/src/features/settings/presentation/recitation_settings.dart';
import 'package:khatma/src/features/settings/presentation/language_setting.dart';
import 'package:khatma/src/features/settings/presentation/notification_settings.dart';
import 'package:khatma/src/features/settings/presentation/theme_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.language,
            title: 'Langues',
            iconColor: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LanguageSettings()),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.menu_book,
            title: 'Mushaf',
            iconColor: Colors.brown,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecitationSettings(),
                ),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.notifications,
            title: 'Notification',
            iconColor: Colors.redAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettings(),
                ),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.brightness_6,
            title: 'Thème',
            iconColor: Colors.purpleAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
