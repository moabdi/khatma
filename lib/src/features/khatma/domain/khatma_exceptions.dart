/// Domain exceptions for Khatma business rules

/// Base exception for domain violations
sealed class KhatmaDomainException implements Exception {
  final String message;
  final String? details;

  const KhatmaDomainException(this.message, [this.details]);

  @override
  String toString() {
    if (details != null) {
      return 'KhatmaDomainException: $message - $details';
    }
    return 'KhatmaDomainException: $message';
  }
}

/// Thrown when trying to modify a completed khatma
class KhatmaCompletedException extends KhatmaDomainException {
  const KhatmaCompletedException([String? details])
      : super('Cannot modify a completed khatma', details);
}

/// Thrown when trying to modify a deleted khatma
class KhatmaDeletedException extends KhatmaDomainException {
  const KhatmaDeletedException([String? details])
      : super('Cannot modify a deleted khatma', details);
}

/// Thrown when a unit is already reserved
class UnitAlreadyReservedException extends KhatmaDomainException {
  const UnitAlreadyReservedException(int unitNumber)
      : super('Unit is already reserved', 'Unit $unitNumber cannot be reserved again');
}

/// Thrown when reservation limit is exceeded
class ReservationLimitExceededException extends KhatmaDomainException {
  const ReservationLimitExceededException(int limit)
      : super('Reservation limit exceeded', 'Maximum $limit reservations per user');
}

/// Thrown when reading limit is exceeded (total reserved + completed)
class ReadingLimitExceededException extends KhatmaDomainException {
  const ReadingLimitExceededException(int limit)
      : super('Reading limit exceeded', 'Maximum $limit units to read per user (reserved + completed)');
}

/// Thrown when trying to complete a non-reserved unit
class UnitNotReservedException extends KhatmaDomainException {
  const UnitNotReservedException(int unitNumber)
      : super('Unit is not reserved', 'Unit $unitNumber must be reserved before completion');
}

/// Thrown when part number is invalid
class InvalidPartNumberException extends KhatmaDomainException {
  const InvalidPartNumberException(int partNumber, int maxParts)
      : super('Invalid part number', 'Part $partNumber is out of range (1-$maxParts)');
}

/// Thrown when trying to add duplicate parts
class DuplicatePartException extends KhatmaDomainException {
  final List<int> duplicates;

  DuplicatePartException(this.duplicates)
      : super('Duplicate parts detected', 'Parts already completed: ${duplicates.join(", ")}');
}

/// Thrown when trying to perform an operation on a unit not owned by the user
class UnitNotOwnedException extends KhatmaDomainException {
  const UnitNotOwnedException(int unitNumber, String userId)
      : super('Unit is not owned by user', 'Unit $unitNumber is not owned by user $userId');
}

/// Thrown when trying to complete an already completed unit
class UnitAlreadyCompletedException extends KhatmaDomainException {
  const UnitAlreadyCompletedException(int unitNumber)
      : super('Unit is already completed', 'Unit $unitNumber has already been completed');
}

/// Thrown when user lacks required privileges for an operation
class InsufficientPrivilegesException extends KhatmaDomainException {
  const InsufficientPrivilegesException(String operation)
      : super('Insufficient privileges', 'User does not have permission to perform: $operation');
}
