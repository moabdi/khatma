import 'package:khatma/src/error/app_error_code.dart';

sealed class AppException implements Exception {
  const AppException(this.code);
  final AppErrorCode code;
  String get message => code.name;
  @override
  String toString() => message;
}

class DomainException extends AppException {
  const DomainException(super.code, [this.details]);
  final String? details;

  @override
  String get message => details ?? super.message;
}

class TechnicalException extends AppException {
  const TechnicalException(super.code, [this.details]);
  final String? details;

  @override
  String get message => details ?? super.message;
}
