import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:khatma/src/features/info/presentation/config/contact_config.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class ContactMethodBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      barrierColor: Theme.of(context).disabledColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _ContactMethodContent(),
    );
  }
}

class _ContactMethodContent extends StatelessWidget {
  const _ContactMethodContent();

  Future<void> _launchEmailForContactType(
    BuildContext context,
    ContactType contactType,
  ) async {
    Navigator.of(context).pop();

    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);

    try {
      final config = ContactConfig.getContactTypeConfig(context, contactType);
      final body = await config.emailTemplate.getBodyTemplate(context);
      final subject =
          config.emailTemplate.getSubjectTemplate(context, config.label);

      final email = Email(
        body: body,
        subject: subject,
        recipients: [ContactConfig.supportEmail],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);

      messenger.showSnackBar(
        SnackBar(
          content: Text(context.loc.openEmailApp),
          backgroundColor: theme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      HapticFeedback.selectionClick();
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.loc.emailNotAvailable),
          backgroundColor: theme.colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );

      HapticFeedback.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
            /// Header
            Text(
              context.loc.chooseContactMethod,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.loc.selectContactTypeDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),

            /// Contact types
            ...ContactType.values.map(
              (type) => ContactListTile(
                contactType: type,
                onTap: () => _launchEmailForContactType(context, type),
              ),
            ),

            const SizedBox(height: 20),
            Divider(height: 10),
            const ContactFooterInfo(),
          ],
        ),
      ),
    );
  }
}

class ContactListTile extends StatelessWidget {
  final ContactType contactType;
  final VoidCallback onTap;

  const ContactListTile({
    super.key,
    required this.contactType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = ContactConfig.getContactTypeConfig(context, contactType);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: config.color.withOpacity(0.1),
          child: Icon(config.icon, color: config.color, size: 20),
        ),
        title: Text(
          config.label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          config.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            height: 1.3,
          ),
        ),
        trailing: Icon(
          Icons.open_in_new,
          color: config.color,
          size: 18,
          semanticLabel: '${config.label} ${context.loc.openEmailApp}',
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class ContactFooterInfo extends StatelessWidget {
  const ContactFooterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.email,
            color: theme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.loc.openEmailApp,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ContactConfig.supportEmail,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
