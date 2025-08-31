import 'package:flutter/material.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';
import 'package:khatma_ui/components/modern_modal_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMethodSelector {
  static void show(BuildContext context) {
    ModernBottomSheet.show(
      context: context,
      title: context.loc.chooseContactMethod,
      subtitle: context.loc.selectContactTypeDescription,
      content: _ContactMethodList(),
    );
  }
}

class _ContactMethodList extends StatelessWidget {
  const _ContactMethodList();

  String _getContactTypeLabel(BuildContext context, ContactType type) {
    switch (type) {
      case ContactType.bug:
        return context.loc.bugReport;
      case ContactType.suggestion:
        return context.loc.suggestion;
      case ContactType.feedback:
        return context.loc.feedback;
      case ContactType.other:
        return context.loc.other;
    }
  }

  String _getContactTypeDescription(BuildContext context, ContactType type) {
    switch (type) {
      case ContactType.bug:
        return 'Report technical issues or problems with the app';
      case ContactType.suggestion:
        return 'Share ideas to improve the app experience';
      case ContactType.feedback:
        return 'General feedback about your app experience';
      case ContactType.other:
        return 'Any other inquiries or questions';
    }
  }

  Color _getContactTypeColor(BuildContext context, ContactType type) {
    final colors = Theme.of(context).colorScheme;
    switch (type) {
      case ContactType.bug:
        return colors.error;
      case ContactType.suggestion:
        return colors.tertiary;
      case ContactType.feedback:
        return colors.primary;
      case ContactType.other:
        return colors.secondary;
    }
  }

  Future<void> _launchEmailForContactType(
    BuildContext context,
    ContactType contactType,
  ) async {
    // Close the modal first
    Navigator.of(context).pop();

    final contactTypeName = _getContactTypeLabel(context, contactType);
    final subject = context.loc.contactFormSubject(contactTypeName);

    final emailBody = '''


    ---
    ${context.loc.sentViaKhatmaApp}
    ''';

    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@khatma.app', // Replace with your support email
      queryParameters: {
        'subject': subject,
        'body': emailBody,
      },
    );

    try {
      final canLaunch = await canLaunchUrl(emailUri);
      if (canLaunch) {
        await launchUrl(emailUri);
      } else {
        _showSnackBar(context, context.loc.unableToOpenEmail, isError: true);
      }
    } catch (e) {
      print('Error launching email: $e');
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
    return Column(
      children: [
        // Header info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.loc.directEmailContact,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Contact type list
        ...ContactType.values.map((contactType) {
          final typeColor = _getContactTypeColor(context, contactType);

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.3),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  contactType.icon,
                  color: typeColor,
                  size: 20,
                ),
              ),
              title: Text(
                _getContactTypeLabel(context, contactType),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _getContactTypeDescription(context, contactType),
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
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.open_in_new,
                  color: typeColor,
                  size: 16,
                ),
              ),
              onTap: () => _launchEmailForContactType(context, contactType),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }).toList(),

        const SizedBox(height: 16),

        // Alternative contact info
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
                      'support@khatma.app',
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
    );
  }
}
