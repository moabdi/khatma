import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/features/profil/login_page.dart';
import 'package:khatma/src/features/profil/settings_page.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma_ui/constants/app_sizes.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({super.key, this.isLoggedIn = false});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          gapH24,
          _buildProfileHeader(),
          if (!isLoggedIn) _buildLoginSuggestion(context),
          gapH48,
          Expanded(child: _buildMenuItems(context)),
          const Divider(height: 20),
          _buildFooter(context),
          gapH12,
        ],
      ),
    );
  }

  Widget _buildLoginSuggestion(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.amber),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Créez un compte en éditant votre profil.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Invité',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          '@guest',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildMenuItem(
            context, Icons.account_circle, 'Se connecter / S' 'inscrire',
            onTap: () {
          context.goNamed(AppRoute.login.name);
        }),
        Divider(),
        _buildMenuItem(
          context,
          Icons.settings,
          'Paramètres',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        Divider(),
        _buildMenuItem(context, Icons.article, 'Mentions légales', onTap: () {
          context.goNamed(AppRoute.MentionsLegales.name);
        }),
        Divider(),
        _buildMenuItem(context, Icons.help, 'About us', onTap: () {
          context.goNamed(AppRoute.aboutUs.name);
        }),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Khatma',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'v1.0.0', // 🔥 Tu peux rendre dynamique plus tard
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
