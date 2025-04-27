import 'package:flutter/material.dart';
import 'package:khatma/src/features/profil/choose_recitation_page.dart';
import 'package:khatma/src/features/profil/language_page.dart';
import 'package:khatma/src/features/profil/notification_settings.dart';
import 'package:khatma/src/features/profil/theme_page.dart';

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
            Icons.language,
            'Langues',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LanguagePage()),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            Icons.book,
            'Mushaf',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChooseRecitationPage(),
                ),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            Icons.notifications,
            'Notification',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            Icons.brightness_6,
            'Thème',
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
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
