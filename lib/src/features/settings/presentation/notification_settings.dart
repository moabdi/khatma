import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  // Variable to track notification settings (default is enabled)
  bool _isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres de notification'),
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
                // Avatar and notification icon at the top
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withAlpha(128),
                  radius: 40,
                  child: Icon(
                    Icons.notifications,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Gérez vos préférences de notification",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Notification enabled/disabled toggle
                SwitchListTile(
                  title: const Text('Activer les notifications'),
                  subtitle: const Text(
                    'Recevez des notifications pour les mises à jour importantes.',
                  ),
                  value: _isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Colors.grey,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
