import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatma/src/i18n/app_localizations_context.dart';

// ===== BASE VALIDATORS =====

abstract class StringValidator {
  bool isValid(String value);
}

class RegexValidator implements StringValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  @override
  bool isValid(String value) {
    try {
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);
      for (final match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({required this.editingValidator});
  final StringValidator editingValidator;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final bool oldValueValid = editingValidator.isValid(oldValue.text);
    final bool newValueValid = editingValidator.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

// ===== SPECIFIC VALIDATORS =====

class EmailValidator extends RegexValidator {
  EmailValidator() : super(regexSource: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
}

class EmailEditingValidator extends RegexValidator {
  EmailEditingValidator() : super(regexSource: '^(|\\S)+\$');
}

class NonEmptyStringValidator extends StringValidator {
  @override
  bool isValid(String value) {
    return value.trim().isNotEmpty;
  }
}

class MinLengthStringValidator extends StringValidator {
  MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) {
    return value.length >= minLength;
  }
}

class PasswordComplexityValidator extends StringValidator {
  @override
  bool isValid(String value) {
    if (value.length < 8) return false;
    if (!RegExp(r'[a-z]').hasMatch(value)) return false;
    if (!RegExp(r'[A-Z]').hasMatch(value)) return false;
    if (!RegExp(r'\d').hasMatch(value)) return false;
    return true;
  }
}

// ===== AUTH VALIDATORS CLASS =====

class AuthValidators {
  // Validator instances
  static final EmailValidator _emailValidator = EmailValidator();
  static final MinLengthStringValidator _nameValidator =
      MinLengthStringValidator(2);
  static final PasswordComplexityValidator _passwordValidator =
      PasswordComplexityValidator();
  static final MinLengthStringValidator _simplePasswordValidator =
      MinLengthStringValidator(1);

  // ===== EMAIL VALIDATION =====

  static bool isValidEmail(String email) {
    return _emailValidator.isValid(email.trim());
  }

  static String? validateEmail(
      String? email, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final trimmedEmail = (email ?? '').trim();
    if (trimmedEmail.isEmpty) {
      return context.loc.emailCannotBeEmpty;
    }
    if (!isValidEmail(trimmedEmail)) {
      return context.loc.invalidEmailFormat;
    }
    return null;
  }

  // ===== PASSWORD VALIDATION =====

  /// For login (simple validation)
  static bool isValidLoginPassword(String password) {
    return _simplePasswordValidator.isValid(password);
  }

  /// For registration/create password (complex validation)
  static bool isValidComplexPassword(String password) {
    return _passwordValidator.isValid(password);
  }

  static String? validateLoginPassword(
      String? password, bool submitted, BuildContext context) {
    if (!submitted) return null;

    if ((password ?? '').isEmpty) {
      return context.loc.passwordCannotBeEmpty;
    }
    return null;
  }

  static String? validateComplexPassword(
      String? password, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final pwd = password ?? '';
    if (pwd.isEmpty) {
      return context.loc.passwordCannotBeEmpty;
    }
    if (pwd.length < 8) {
      return context.loc.passwordMinLength;
    }
    if (!RegExp(r'[a-z]').hasMatch(pwd)) {
      return context.loc.passwordNeedsLowercase;
    }
    if (!RegExp(r'[A-Z]').hasMatch(pwd)) {
      return context.loc.passwordNeedsUppercase;
    }
    if (!RegExp(r'\d').hasMatch(pwd)) {
      return context.loc.passwordNeedsDigit;
    }
    return null;
  }

  // ===== CONFIRM PASSWORD VALIDATION =====

  static String? validateConfirmPassword(String? password,
      String? confirmPassword, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final confirm = confirmPassword ?? '';
    if (confirm.isEmpty) {
      return context.loc.pleaseConfirmPassword;
    }
    if (confirm != (password ?? '')) {
      return context.loc.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateCurrentPassword(
      String? value, bool submitted, BuildContext context) {
    if (!submitted) return null;
    if (value == null || value.trim().isEmpty) {
      return context.loc.currentPasswordRequired;
    }
    return null;
  }

  // ===== NAME VALIDATION =====

  static bool isValidName(String name) {
    return _nameValidator.isValid(name.trim());
  }

  static String? validateName(
      String? name, bool submitted, BuildContext context) {
    if (!submitted) return null;

    final trimmedName = (name ?? '').trim();
    if (trimmedName.isEmpty) {
      return context.loc.nameCannotBeEmpty;
    }
    if (trimmedName.length < 2) {
      return context.loc.nameMinLength;
    }
    return null;
  }

  // ===== FORM VALIDATION HELPERS =====

  /// For login form
  static bool canSubmitLoginForm({
    required String email,
    required String password,
  }) {
    return isValidEmail(email) && isValidLoginPassword(password);
  }

  /// For registration form
  static bool canSubmitRegistrationForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool acceptedTerms,
  }) {
    return isValidName(name) &&
        isValidEmail(email) &&
        isValidComplexPassword(password) &&
        password == confirmPassword &&
        acceptedTerms;
  }

  /// For create password form
  static bool canSubmitCreatePasswordForm({
    required String password,
    required String confirmPassword,
  }) {
    return isValidComplexPassword(password) && password == confirmPassword;
  }

  /// For forgot password form
  static bool canSubmitForgotPasswordForm({
    required String email,
  }) {
    return isValidEmail(email);
  }
}

// ===== MIXINS FOR DIFFERENT PAGES =====

/// Mixin for login page
mixin LoginValidatorsMixin {
  String? validateEmail(String? email, bool submitted, BuildContext context) {
    return AuthValidators.validateEmail(email, submitted, context);
  }

  String? validatePassword(
      String? password, bool submitted, BuildContext context) {
    return AuthValidators.validateLoginPassword(password, submitted, context);
  }

  bool canSubmitForm({required String email, required String password}) {
    return AuthValidators.canSubmitLoginForm(email: email, password: password);
  }
}

/// Mixin for registration page
mixin RegistrationValidatorsMixin {
  String? validateName(String? name, bool submitted, BuildContext context) {
    return AuthValidators.validateName(name, submitted, context);
  }

  String? validateEmail(String? email, bool submitted, BuildContext context) {
    return AuthValidators.validateEmail(email, submitted, context);
  }

  String? validatePassword(
      String? password, bool submitted, BuildContext context) {
    return AuthValidators.validateComplexPassword(password, submitted, context);
  }

  String? validateConfirmPassword(String? password, String? confirmPassword,
      bool submitted, BuildContext context) {
    return AuthValidators.validateConfirmPassword(
        password, confirmPassword, submitted, context);
  }

  String? validateCurrentPassword(
      String? value, bool submitted, BuildContext context) {
    return AuthValidators.validateCurrentPassword(value, submitted, context);
  }

  bool canSubmitForm({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool acceptedTerms,
  }) {
    return AuthValidators.canSubmitRegistrationForm(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      acceptedTerms: acceptedTerms,
    );
  }
}

/// Mixin for create/reset password page
mixin CreatePasswordValidatorsMixin {
  String? validatePassword(
      String? password, bool submitted, BuildContext context) {
    return AuthValidators.validateComplexPassword(password, submitted, context);
  }

  String? validateConfirmPassword(String? password, String? confirmPassword,
      bool submitted, BuildContext context) {
    return AuthValidators.validateConfirmPassword(
        password, confirmPassword, submitted, context);
  }

  bool canSubmitForm({
    required String password,
    required String confirmPassword,
  }) {
    return AuthValidators.canSubmitCreatePasswordForm(
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}

/// Mixin for forgot password page
mixin ForgotPasswordValidatorsMixin {
  String? validateEmail(String? email, bool submitted, BuildContext context) {
    return AuthValidators.validateEmail(email, submitted, context);
  }

  bool canSubmitForm({required String email}) {
    return AuthValidators.canSubmitForgotPasswordForm(email: email);
  }
}

/// Mixin for account/profile pages
mixin AccountValidatorsMixin {
  String? validateName(String? name, bool submitted, BuildContext context) {
    return AuthValidators.validateName(name, submitted, context);
  }

  String? validateEmail(String? email, bool submitted, BuildContext context) {
    return AuthValidators.validateEmail(email, submitted, context);
  }

  String? validateCurrentPassword(
      String? password, bool submitted, BuildContext context) {
    return AuthValidators.validateLoginPassword(password, submitted, context);
  }

  String? validateNewPassword(
      String? password, bool submitted, BuildContext context) {
    return AuthValidators.validateComplexPassword(password, submitted, context);
  }

  String? validateConfirmPassword(String? password, String? confirmPassword,
      bool submitted, BuildContext context) {
    return AuthValidators.validateConfirmPassword(
        password, confirmPassword, submitted, context);
  }
}
