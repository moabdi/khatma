import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/features/info/presentation/config/contact_config.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class ContactMethodBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _ContactMethodContent(),
    );
  }
}

class _ContactMethodContent extends StatelessWidget {
  const _ContactMethodContent();

  Future<void> _launchEmailForContactType(
    BuildContext context,
    ContactType contactType,
  ) async {
    // Close the modal first
    Navigator.of(context).pop();

    try {
      final config = ContactConfig.getContactTypeConfig(context, contactType);
      var body = await config.emailTemplate.getBodyTemplate(context);
      final Email email = Email(
        body: body,
        subject: config.emailTemplate.getSubjectTemplate(context, config.label),
        recipients: [ContactConfig.supportEmail],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (error) {
        print('Email sending error: $error');
        // Re-throw to be caught by the calling method
        throw Exception('Failed to send email: $error');
      }
    } catch (e) {
      print('Error sending email: $e');
      _showSnackBar(context, context.loc.emailNotAvailable, isError: true);
    }
  }

  void _showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[600] : Colors.green[600],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        left: 24,
        right: 24,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            context.loc.chooseContactMethod,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            context.loc.selectContactTypeDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 24),

          // Contact type list
          ...ContactType.values.map((contactType) {
            final config =
                ContactConfig.getContactTypeConfig(context, contactType);

            return Column(
              children: [
                ListTile(
                  dense: true,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: config.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      config.icon,
                      color: config.color,
                      size: 22,
                    ),
                  ),
                  title: Text(
                    config.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      config.description,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: config.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.open_in_new,
                      color: config.color,
                      size: 16,
                    ),
                  ),
                  onTap: () => _launchEmailForContactType(context, contactType),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Divider(),
              ],
            );
          }).toList(),

          const SizedBox(height: 16),

          // Footer info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ContactConfig.supportEmail,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
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
