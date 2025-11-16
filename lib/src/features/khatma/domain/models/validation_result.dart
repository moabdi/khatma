import 'package:khatma/src/error/app_error_code.dart';

class ValidationResult {
  final bool isValid;
  final List<AppErrorCode> errors;

  const ValidationResult({
    required this.isValid,
    this.errors = const [],
  });

  ValidationResult copyWith({
    bool? isValid,
    List<AppErrorCode>? errors,
  }) {
    return ValidationResult(
      isValid: isValid ?? this.isValid,
      errors: errors ?? this.errors,
    );
  }
}
