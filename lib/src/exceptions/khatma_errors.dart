/// Base class for all Khatma-related errors
sealed class KhatmaError {
  const KhatmaError(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Validation errors
final class ValidationError extends KhatmaError {
  const ValidationError(super.message, this.field);
  final String field;

  @override
  String toString() => 'Validation Error in $field: $message';
}

/// Network-related errors
final class NetworkError extends KhatmaError {
  const NetworkError(super.message, [this.statusCode]);
  final int? statusCode;

  @override
  String toString() => 'Network Error ${statusCode ?? ''}: $message';
}

/// Data persistence errors
final class StorageError extends KhatmaError {
  const StorageError(super.message);

  @override
  String toString() => 'Storage Error: $message';
}

/// Business logic errors
final class BusinessLogicError extends KhatmaError {
  const BusinessLogicError(super.message);

  @override
  String toString() => 'Business Logic Error: $message';
}

/// Not found errors
final class NotFoundError extends KhatmaError {
  const NotFoundError(this.resourceType, this.id)
      : super('$resourceType with id $id not found');

  final String resourceType;
  final String id;
}
