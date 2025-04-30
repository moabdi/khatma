import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(AppRoute.home.name);
          },
        ),
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
          context,
          icon: Icons.account_circle,
          iconColor: Theme.of(context).colorScheme.warning,
          title: 'Se connecter / S\'inscrire',
          onTap: () {
            context.goNamed(AppRoute.login.name);
          },
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: Icons.settings,
          iconColor: Colors.blueGrey,
          title: 'Paramètres',
          onTap: () {
            context.goNamed(AppRoute.settings.name);
          },
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: Icons.question_answer,
          iconColor: Colors.blueGrey,
          title: 'FAQ',
          onTap: () {
            context.goNamed(AppRoute.faq.name);
          },
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: Icons.article,
          iconColor: Colors.blueGrey,
          title: 'Mentions légales',
          onTap: () {
            context.goNamed(AppRoute.mentionsLegales.name);
          },
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: Icons.help,
          iconColor: Colors.blueGrey,
          title: 'À propos de nous',
          onTap: () {
            context.goNamed(AppRoute.aboutUs.name);
          },
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: Icons.feedback,
          iconColor: Colors.blueGrey,
          title: 'Question / Suggestion',
          onTap: () {
            context.goNamed(AppRoute.contact.name);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
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
          'v1.0.0', // 🔥 Peut être rendu dynamique plus tard
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
