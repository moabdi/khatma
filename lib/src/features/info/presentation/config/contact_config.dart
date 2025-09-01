import 'package:flutter/material.dart';
import 'package:khatma/src/core/services/device_info_service.dart';
import 'package:khatma/src/features/info/presentation/validators/contact_validators.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

class ContactConfig {
  // Email configuration
  static const String supportEmail = 'houari.mostapha@gmail.com';
  static const String appName = 'Khatma';

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
          description: context.loc.bugReportDescription,
          icon: Icons.bug_report,
          color: Colors.red.shade600,
          emailTemplate: EmailTemplate.bugReport,
        );
      case ContactType.suggestion:
        return ContactTypeConfig(
          label: context.loc.suggestion,
          description: context.loc.suggestionDescription,
          icon: Icons.lightbulb_outline,
          color: Colors.blue.shade600,
          emailTemplate: EmailTemplate.suggestion,
        );
      case ContactType.feedback:
        return ContactTypeConfig(
          label: context.loc.feedback,
          description: context.loc.feedbackDescription,
          icon: Icons.feedback_outlined,
          color: Colors.green.shade600,
          emailTemplate: EmailTemplate.feedback,
        );
      case ContactType.other:
        return ContactTypeConfig(
          label: context.loc.other,
          description: context.loc.otherDescription,
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

  Future<String> getBodyTemplate(BuildContext context,
      {String? customMessage}) async {
    final deviceInfo = await DeviceInfoService().getDeviceInfo();

    switch (this) {
      case EmailTemplate.bugReport:
        return '''




---
Bug report Details:
  ${deviceInfo.debugInfos()}
---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.suggestion:
        return '''




---
Suggestion Details:
${deviceInfo.appInfos()}
---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.feedback:
        return '''





---
Feedback Details:
${deviceInfo.appInfos()}
---
${context.loc.sentViaKhatmaApp}
        ''';
      case EmailTemplate.other:
        return '''




---
Feedback Details:
${deviceInfo.appInfos()}
---
${context.loc.sentViaKhatmaApp}
        ''';
    }
  }
}
