import 'package:flutter/material.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class ContactConfig {
  // Email configuration
  static const String supportEmail = 'support@khatma.app';
  static const String appName = 'Khatma App';

  // Response time information
  static const String responseTimeHours = '24-48';

  // Contact type configurations
  static ContactTypeConfig getContactTypeConfig(
    BuildContext context,
    ContactType type,
  ) {
    switch (type) {
      case ContactType.bug:
        return ContactTypeConfig(
          label: context.loc.bugReport,
          description: 'Report technical issues or problems with the app',
          icon: Icons.bug_report,
          color: Colors.red.shade600,
          emailTemplate: EmailTemplate.bugReport,
        );
      case ContactType.suggestion:
        return ContactTypeConfig(
          label: context.loc.suggestion,
          description: 'Share ideas to improve the app experience',
          icon: Icons.lightbulb_outline,
          color: Colors.blue.shade600,
          emailTemplate: EmailTemplate.suggestion,
        );
      case ContactType.feedback:
        return ContactTypeConfig(
          label: context.loc.feedback,
          description: 'General feedback about your app experience',
          icon: Icons.feedback_outlined,
          color: Colors.green.shade600,
          emailTemplate: EmailTemplate.feedback,
        );
      case ContactType.other:
        return ContactTypeConfig(
          label: context.loc.other,
          description: 'Any other inquiries or questions',
          icon: Icons.help_outline,
          color: Colors.orange.shade600,
          emailTemplate: EmailTemplate.other,
        );
    }
  }
}

class ContactTypeConfig {
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final EmailTemplate emailTemplate;

  const ContactTypeConfig({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.emailTemplate,
  });
}

enum EmailTemplate {
  bugReport,
  suggestion,
  feedback,
  other,
}

extension EmailTemplateExtension on EmailTemplate {
  String getSubjectTemplate(BuildContext context, String contactTypeName) {
    return context.loc.contactFormSubject(contactTypeName);
  }

  String getBodyTemplate(BuildContext context, {String? customMessage}) {
    final baseBody = customMessage ?? '';

    switch (this) {
      case EmailTemplate.bugReport:
        return '''
$baseBody

---
Bug Report Details:
- Device: [Please specify your device]
- App Version: [Please specify app version]
- Steps to reproduce: [Please describe the steps]

---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.suggestion:
        return '''
$baseBody

---
Suggestion Details:
- Feature Request: [Please describe the feature]
- Expected Behavior: [How should it work?]
- Use Case: [When would you use this?]

---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.feedback:
        return '''
$baseBody

---
Feedback Details:
- Overall Experience: [Rate your experience]
- What you liked: [Tell us what works well]
- What could be improved: [Tell us what needs work]

---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.other:
        return '''
$baseBody

---
${context.loc.sentViaKhatmaApp}
        ''';
    }
  }
}
