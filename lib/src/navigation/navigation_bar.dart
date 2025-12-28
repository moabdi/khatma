import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma/src/routing/app_router.dart';
import 'package:khatma/src/themes/theme.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedLabelStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(fontSize: 14, fontWeight: FontWeight.w600);

    var unselectedLabelStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        );
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: context.colorScheme.primary,
      unselectedLabelStyle: unselectedLabelStyle,
      selectedLabelStyle: selectedLabelStyle,
      items: <BottomNavigationBarItem>[
        item(context, icon: Icons.home_filled, label: context.loc.home),
        item(context, icon: FontAwesomeIcons.book, label: context.loc.quran),
        item(context, icon: Icons.add_box_outlined, label: context.loc.create),
        item(context, icon: Icons.person, label: context.loc.profile),
      ],
      onTap: (value) {
        switch (value) {
          case 0:
            context.goNamed(AppRoute.home.name);
            break;
          case 1:
            context.goNamed(
              AppRoute.quran.name,
              pathParameters: {'idSourat': "1", 'idVerset': "1"},
            );
            break;
          case 2:
            _showAddKhatmaMenu(context);
            break;
          case 3:
            context.goNamed(AppRoute.profil.name);
            break;
        }
      },
    );
  }

  void _showAddKhatmaMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _AddKhatmaMenuContent(),
    );
  }

  void addKhatma(BuildContext context) =>
      context.goNamed(AppRoute.addKhatma.name);

  void openQuran(BuildContext context) {
    return context.goNamed(
      AppRoute.quran.name,
      pathParameters: {'idSourat': "1", 'idVerset': "1"},
    );
  }

  void goHome(BuildContext context) => context.goNamed(AppRoute.home.name);

  BottomNavigationBarItem item(BuildContext context,
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class _AddKhatmaMenuContent extends StatelessWidget {
  const _AddKhatmaMenuContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 20,
        right: 20,
        top: 8,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.loc.addKhatmaMenuTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Menu options
            _MenuListTile(
              icon: Icons.add_circle_outline,
              iconColor: colorScheme.primary,
              title: context.loc.createKhatma,
              subtitle: context.loc.createKhatmaDescription,
              onTap: () {
                Navigator.of(context).pop();
                context.goNamed(AppRoute.addKhatma.name);
              },
            ),
            const SizedBox(height: 8),
            _MenuListTile(
              icon: Icons.qr_code_2,
              iconColor: colorScheme.secondary,
              title: context.loc.joinPublicKhatma,
              subtitle: context.loc.joinPublicKhatmaDescription,
              onTap: () {
                Navigator.of(context).pop();
                context.pushNamed(AppRoute.khatmaSearch.name);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuListTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconColor.withValues(alpha: 0.1),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.3,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
