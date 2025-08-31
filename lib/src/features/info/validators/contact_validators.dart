import 'package:flutter/material.dart';
import 'package:khatma/src/features/authentication/presentation/validators/auth_validators.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

// ===== CONTACT FORM VALIDATORS =====

class ContactValidators {
  // Use existing validators from AuthValidators
  static final _emailValidator = AuthValidators._emailValidator;
  static final _nameValidator = AuthValidators._nameValidator;

  // Contact-specific validator
  static final MinLengthStringValidator _messageValidator =
      MinLengthStringValidator(10);

  // ===== NAME VALIDATION =====

  static bool isValidContactName(String name) {
    return _nameValidator.isValid(name.trim());
  }

  static String? validateContactName(
      String? name, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final trimmedName = (name ?? '').trim();
    if (trimmedName.isEmpty) {
      return context.loc.pleaseEnterYourName;
    }
    if (trimmedName.length < 2) {
      return context.loc.nameMustBeAtLeast2Characters;
    }
    return null;
  }

  // ===== EMAIL VALIDATION =====

  static bool isValidContactEmail(String email) {
    return _emailValidator.isValid(email.trim());
  }

  static String? validateContactEmail(
      String? email, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final trimmedEmail = (email ?? '').trim();
    if (trimmedEmail.isEmpty) {
      return context.loc.pleaseEnterYourEmail;
    }
    if (!_emailValidator.isValid(trimmedEmail)) {
      return context.loc.pleaseEnterValidEmail;
    }
    return null;
  }

  // ===== MESSAGE VALIDATION =====

  static bool isValidMessage(String message) {
    return _messageValidator.isValid(message.trim());
  }

  static String? validateMessage(
      String? message, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final trimmedMessage = (message ?? '').trim();
    if (trimmedMessage.isEmpty) {
      return context.loc.pleaseEnterYourMessage;
    }
    if (trimmedMessage.length < 10) {
      return context.loc.messageMustBeAtLeast10Characters;
    }
    return null;
  }

  // ===== FORM VALIDATION HELPERS =====

  /// Validate complete contact form
  static bool canSubmitContactForm({
    required String name,
    required String email,
    required String message,
  }) {
    return isValidContactName(name) &&
        isValidContactEmail(email) &&
        isValidMessage(message);
  }
}

// ===== CONTACT FORM VALIDATION MIXIN =====

/// Mixin for contact form validation
mixin ContactFormValidatorsMixin {
  bool _submitted = false;

  /// Set submitted state - call this when form is submitted
  void setFormSubmitted() {
    _submitted = true;
  }

  /// Reset submitted state - call this when form is cleared
  void resetFormSubmitted() {
    _submitted = false;
  }

  /// Get current submitted state
  bool get isFormSubmitted => _submitted;

  // ===== VALIDATION METHODS =====

  String? validateContactName(String? name, BuildContext context) {
    return ContactValidators.validateContactName(name, _submitted, context);
  }

  String? validateContactEmail(String? email, BuildContext context) {
    return ContactValidators.validateContactEmail(email, _submitted, context);
  }

  String? validateContactMessage(String? message, BuildContext context) {
    return ContactValidators.validateMessage(message, _submitted, context);
  }

  // ===== FORM VALIDATION HELPERS =====

  bool canSubmitContactForm({
    required String name,
    required String email,
    required String message,
  }) {
    return ContactValidators.canSubmitContactForm(
      name: name,
      email: email,
      message: message,
    );
  }

  /// Validate and get form data if valid
  ContactFormData? getValidatedContactFormData({
    required String name,
    required String email,
    required String message,
    required ContactType contactType,
  }) {
    final formData = ContactFormData(
      name: name,
      email: email,
      message: message,
      contactType: contactType,
    );

    return formData.isValid ? formData : null;
  }
}

// ===== CONTACT FORM DATA CLASS =====

enum ContactType {
  bug('bug_report', Icons.bug_report),
  suggestion('suggestion', Icons.lightbulb_outline),
  feedback('feedback', Icons.feedback_outlined),
  other('other', Icons.help_outline);

  const ContactType(this.key, this.icon);
  final String key;
  final IconData icon;
}

class ContactFormData {
  final String name;
  final String email;
  final String message;
  final ContactType contactType;

  const ContactFormData({
    required this.name,
    required this.email,
    required this.message,
    required this.contactType,
  });

  bool get isValid =>
      name.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      message.trim().isNotEmpty &&
      ContactValidators.isValidContactEmail(email) &&
      ContactValidators.isValidContactName(name) &&
      ContactValidators.isValidMessage(message);

  String getLocalizedSubject(BuildContext context) {
    final contactTypeName = _getContactTypeName(context);
    return context.loc.contactFormSubject(contactTypeName);
  }

  String _getContactTypeName(BuildContext context) {
    switch (contactType) {
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

  String getLocalizedBody(BuildContext context) => '''
    $message

    ---
    ${context.loc.sentViaKhatmaApp}
  ''';

  @override
  String toString() {
    return 'ContactFormData(name: $name, email: $email, type: ${contactType.key})';
  }
}
