part of 'khatma.dart';

// ============================================================================
// SHARED KHATMA - CONFIGURATION
// ============================================================================

/// Join method for shared khatma
enum JoinMethod {
  code, // Join by code only
  invitation, // Join by invitation with validation
  both; // Both code and invitation
}

/// Configuration for Shared-specific settings
class SharedConfig {
  final String? inviteCode;
  final int maxReservationsPerUser;
  final int maxUnitsToRead; // Limit parts authorized to read
  final int reservationWarningDays;
  final int? reservationExpirationDays;
  final bool autoReleaseExpiredReservations;
  final JoinMethod joinMethod;
  final bool allowMultipleGroups; // Open for multiple groups or one only
  final List<String> tags; // Tags for categorization

  const SharedConfig({
    this.inviteCode,
    required this.maxReservationsPerUser,
    required this.maxUnitsToRead,
    required this.reservationWarningDays,
    this.reservationExpirationDays,
    required this.autoReleaseExpiredReservations,
    this.joinMethod = JoinMethod.code,
    this.allowMultipleGroups = false,
    this.tags = const [],
  });

  const SharedConfig.defaults()
      : inviteCode = null,
        maxReservationsPerUser = 3,
        maxUnitsToRead = 10,
        reservationWarningDays = 7,
        reservationExpirationDays = null,
        autoReleaseExpiredReservations = true,
        joinMethod = JoinMethod.code,
        allowMultipleGroups = false,
        tags = const [];

  SharedConfig copyWith({
    String? inviteCode,
    int? maxReservationsPerUser,
    int? maxUnitsToRead,
    int? reservationWarningDays,
    int? reservationExpirationDays,
    bool? autoReleaseExpiredReservations,
    JoinMethod? joinMethod,
    bool? allowMultipleGroups,
    List<String>? tags,
  }) {
    return SharedConfig(
      inviteCode: inviteCode ?? this.inviteCode,
      maxReservationsPerUser:
          maxReservationsPerUser ?? this.maxReservationsPerUser,
      maxUnitsToRead: maxUnitsToRead ?? this.maxUnitsToRead,
      reservationWarningDays:
          reservationWarningDays ?? this.reservationWarningDays,
      reservationExpirationDays:
          reservationExpirationDays ?? this.reservationExpirationDays,
      autoReleaseExpiredReservations:
          autoReleaseExpiredReservations ?? this.autoReleaseExpiredReservations,
      joinMethod: joinMethod ?? this.joinMethod,
      allowMultipleGroups: allowMultipleGroups ?? this.allowMultipleGroups,
      tags: tags ?? this.tags,
    );
  }
}

// ============================================================================
// SHARED KHATMA - DOMAIN MODEL
// ============================================================================

/// Shared Khatma - Collaborative group reading
class KhatmaShared extends Khatma {
  final SharedConfig config;
  final List<Participant> participants;
  final List<Unit> units;
  final DateTime? lastActivityDate;
  final String? lastActivityUserId;

  const KhatmaShared({
    super.id,
    required super.name,
    super.description,
    required super.unit,
    required super.createDate,
    super.startDate,
    super.endDate,
    required super.theme,
    super.status = KhatmaStatus.active,
    super.lastUpdated,
    super.lastSync,
    super.needsSync = false,
    required super.creatorId,
    super.creatorName,
    super.updatedBy,
    super.repeat = false,
    super.repeats = 0,
    super.progress = 0.0,
    super.version = 1,
    this.config = const SharedConfig.defaults(),
    this.participants = const [],
    this.units = const [],
    this.lastActivityDate,
    this.lastActivityUserId,
  }) : super(type: KhatmaType.shared);

  // Convenience getters for config fields
  String? get inviteCode => config.inviteCode;
  int get maxReservationsPerUser => config.maxReservationsPerUser;
  int get reservationWarningDays => config.reservationWarningDays;
  int? get reservationExpirationDays => config.reservationExpirationDays;
  bool get autoReleaseExpiredReservations => config.autoReleaseExpiredReservations;

  // Privilege checking helpers
  bool isCreator(String userId) => creatorId! == userId;

  bool isAdmin(String userId) {
    final participant = participants.where((p) => p.userId == userId).firstOrNull;
    return participant?.role == ParticipantRole.admin;
  }

  bool hasPrivileges(String userId) => isCreator(userId) || isAdmin(userId);

  // Computed properties
  int get membersCount => participants.length;

  int get unitsAvailable =>
      units.where((unit) => unit.status == UnitStatus.free).length;

  int get totalUnits => unit.count;

  List<Unit> get reservedUnits =>
      units.where((unit) => unit.status == UnitStatus.reserved).toList();

  // Get units reserved by a specific user
  List<Unit> userReservedUnits(String userId) =>
      units.where((unit) => unit.reservedBy == userId && unit.status == UnitStatus.reserved).toList();

  // Get units completed by a specific user
  List<Unit> userCompletedUnits(String userId) =>
      units.where((unit) => unit.completedBy == userId && unit.status == UnitStatus.completed).toList();

  // Get total units (reserved + completed) for a user
  int userTotalUnits(String userId) =>
      userReservedUnits(userId).length + userCompletedUnits(userId).length;

  // Check if user can reserve more units (checks both limits)
  bool canUserReserveMore(String userId) {
    final reserved = userReservedUnits(userId).length;
    final total = userTotalUnits(userId);
    return reserved < maxReservationsPerUser && total < config.maxUnitsToRead;
  }

  // Get remaining reservations for a user (considers both limits)
  int remainingReservations(String userId) {
    final reserved = userReservedUnits(userId).length;
    final total = userTotalUnits(userId);
    final remainingByReservationLimit = maxReservationsPerUser - reserved;
    final remainingByReadLimit = config.maxUnitsToRead - total;
    return remainingByReservationLimit.clamp(0, remainingByReadLimit).clamp(0, maxReservationsPerUser);
  }

  double get completionPercent {
    if (units.isEmpty) return 0.0;
    final completedCount =
        units.where((unit) => unit.status == UnitStatus.completed).length;
    return (completedCount / totalUnits).clamp(0.0, 1.0);
  }

  List<Unit> get unitsNeedingReminders {
    return units.where((unit) => unit.needsReminder).toList();
  }

  List<Unit> get expiredUnits {
    if (reservationExpirationDays == null) return [];
    return units.where((unit) => unit.hasExpired(reservationExpirationDays)).toList();
  }

  bool get hasRecentActivity {
    if (lastActivityDate == null) return false;
    final daysSinceActivity = DateTime.now().difference(lastActivityDate!).inDays;
    return daysSinceActivity <= 7;
  }

  // Domain validation methods
  bool canReserve(Unit unit, String userId) {
    // Cannot reserve if already completed
    if (unit.isCompleted) return false;

    // Cannot reserve if already reserved by someone
    if (unit.isReserved && unit.reservedBy != userId) return false;

    // Check if user has reached reservation limit
    final userReserved = userReservedUnits(userId);
    if (userReserved.length >= maxReservationsPerUser) {
      return false;
    }

    // Check if user has reached reading limit (total units)
    final userTotal = userTotalUnits(userId);
    if (userTotal >= config.maxUnitsToRead) {
      return false;
    }

    return unit.isFree || unit.reservedBy == userId;
  }

  // Domain methods for unit management
  KhatmaShared reserveUnit(int unitNumber, String userId, String userName) {
    assertActive();

    // Validate unit number is within valid range
    if (unitNumber < 1 || unitNumber > totalUnits) {
      throw InvalidPartNumberException(unitNumber, totalUnits);
    }

    // Check reservation limit
    final userReserved = userReservedUnits(userId);
    if (userReserved.length >= maxReservationsPerUser) {
      throw ReservationLimitExceededException(maxReservationsPerUser);
    }

    // Check reading limit (total units)
    final userTotal = userTotalUnits(userId);
    if (userTotal >= config.maxUnitsToRead) {
      throw ReadingLimitExceededException(config.maxUnitsToRead);
    }

    final unitIndex = units.indexWhere((u) => u.number == unitNumber);
    final now = DateTime.now();
    final updatedUnits = List<Unit>.from(units);

    if (unitIndex == -1) {
      // Unit doesn't exist in array, create and add it
      final newUnit = Unit(
        number: unitNumber,
        status: UnitStatus.reserved,
        reservedBy: userId,
        reservedByName: userName,
        reservedDate: now,
      );
      updatedUnits.add(newUnit);
    } else {
      // Unit exists, validate and update it
      final unit = units[unitIndex];

      // Cannot reserve completed units
      if (unit.isCompleted) {
        throw UnitAlreadyCompletedException(unitNumber);
      }

      // Check if unit is already reserved by someone else
      if (unit.isReserved && unit.reservedBy != userId) {
        throw UnitAlreadyReservedException(unitNumber);
      }

      updatedUnits[unitIndex] = unit.copyWith(
        status: UnitStatus.reserved,
        reservedBy: userId,
        reservedByName: userName,
        reservedDate: now,
      );
    }

    return copyWith(
      units: updatedUnits,
      lastActivityDate: now,
      lastActivityUserId: userId,
      lastUpdated: now,
      needsSync: true,
    );
  }

  KhatmaShared completeUnit(int unitNumber, String userId, String userName) {
    assertActive();

    final unitIndex = units.indexWhere((u) => u.number == unitNumber);
    if (unitIndex == -1) {
      throw InvalidPartNumberException(unitNumber, totalUnits);
    }

    final unit = units[unitIndex];

    // Cannot complete an already completed unit
    if (unit.isCompleted) {
      throw UnitAlreadyCompletedException(unitNumber);
    }

    // Unit must be reserved before completion
    if (!unit.isReserved) {
      throw UnitNotReservedException(unitNumber);
    }

    // Only the owner or privileged users (admin/creator) can complete
    if (unit.reservedBy != userId && !hasPrivileges(userId)) {
      throw UnitNotOwnedException(unitNumber, userId);
    }

    final now = DateTime.now();
    final updatedUnits = List<Unit>.from(units);
    updatedUnits[unitIndex] = unit.copyWith(
      status: UnitStatus.completed,
      completedDate: now,
      completedBy: userId,
      completedByName: userName,
    );

    // Update participant's completed count
    final participantIndex = participants.indexWhere((p) => p.userId == userId);
    List<Participant> updatedParticipants = List.from(participants);
    if (participantIndex != -1) {
      updatedParticipants[participantIndex] = participants[participantIndex].copyWith(
        completedUnits: participants[participantIndex].completedUnits + 1,
      );
    }

    return copyWith(
      units: updatedUnits,
      participants: updatedParticipants,
      lastActivityDate: now,
      lastActivityUserId: userId,
      lastUpdated: now,
      needsSync: true,
    );
  }

  KhatmaShared releaseUnit(int unitNumber, String userId) {
    assertActive();

    final unitIndex = units.indexWhere((u) => u.number == unitNumber);
    if (unitIndex == -1) {
      throw InvalidPartNumberException(unitNumber, totalUnits);
    }

    final unit = units[unitIndex];

    // Can only release reserved units
    if (!unit.isReserved) {
      return this;
    }

    // Only the owner or privileged users (admin/creator) can release
    if (unit.reservedBy != userId && !hasPrivileges(userId)) {
      throw UnitNotOwnedException(unitNumber, userId);
    }

    final now = DateTime.now();
    final updatedUnits = List<Unit>.from(units);
    updatedUnits[unitIndex] = unit.copyWith(
      status: UnitStatus.free,
      reservedBy: null,
      reservedByName: null,
      reservedDate: null,
    );

    return copyWith(
      units: updatedUnits,
      lastActivityDate: now,
      lastActivityUserId: userId,
      lastUpdated: now,
      needsSync: true,
    );
  }

  // ============================================================================
  // PARTICIPANT MANAGEMENT METHODS
  // ============================================================================

  /// Add a participant (with pending status if invitation is required)
  KhatmaShared addParticipant({
    required String userId,
    required String userName,
    String? userPhotoUrl,
  }) {
    assertActive();

    // Check if user is already a participant
    if (participants.any((p) => p.userId == userId)) {
      throw Exception('User is already a participant');
    }

    final now = DateTime.now();
    final status = config.joinMethod == JoinMethod.invitation
        ? ParticipantStatus.pending
        : ParticipantStatus.approved;

    final newParticipant = Participant(
      userId: userId,
      userName: userName,
      userPhotoUrl: userPhotoUrl,
      joinedDate: now,
      status: status,
    );

    final updatedParticipants = [...participants, newParticipant];

    return copyWith(
      participants: updatedParticipants,
      lastActivityDate: now,
      lastActivityUserId: userId,
      lastUpdated: now,
      needsSync: true,
    );
  }

  /// Approve a pending participant (admin only)
  KhatmaShared approveParticipant(String userId, String adminId) {
    assertActive();

    // Check if admin has privileges
    if (!hasPrivileges(adminId)) {
      throw InsufficientPrivilegesException('approve participant');
    }

    // Find the participant
    final participantIndex = participants.indexWhere((p) => p.userId == userId);
    if (participantIndex == -1) {
      throw Exception('Participant not found');
    }

    final participant = participants[participantIndex];
    if (!participant.isPending) {
      throw Exception('Participant is not pending approval');
    }

    final updatedParticipants = List<Participant>.from(participants);
    updatedParticipants[participantIndex] = participant.copyWith(
      status: ParticipantStatus.approved,
    );

    return copyWith(
      participants: updatedParticipants,
      lastActivityDate: DateTime.now(),
      lastActivityUserId: adminId,
      lastUpdated: DateTime.now(),
      needsSync: true,
    );
  }

  /// Reject a pending participant (admin only) - removes them from the list
  KhatmaShared rejectParticipant(String userId, String adminId) {
    assertActive();

    // Check if admin has privileges
    if (!hasPrivileges(adminId)) {
      throw InsufficientPrivilegesException('reject participant');
    }

    // Find the participant
    final participant = participants.firstWhere(
      (p) => p.userId == userId,
      orElse: () => throw Exception('Participant not found'),
    );

    if (!participant.isPending) {
      throw Exception('Can only reject pending participants');
    }

    final updatedParticipants = participants.where((p) => p.userId != userId).toList();

    return copyWith(
      participants: updatedParticipants,
      lastActivityDate: DateTime.now(),
      lastActivityUserId: adminId,
      lastUpdated: DateTime.now(),
      needsSync: true,
    );
  }

  /// Block a participant (admin only) - keeps them in the list but blocks participation
  KhatmaShared blockParticipant(String userId, String adminId) {
    assertActive();

    // Check if admin has privileges
    if (!hasPrivileges(adminId)) {
      throw InsufficientPrivilegesException('block participant');
    }

    // Find the participant
    final participantIndex = participants.indexWhere((p) => p.userId == userId);
    if (participantIndex == -1) {
      throw Exception('Participant not found');
    }

    // Cannot block the creator
    if (userId == creatorId) {
      throw Exception('Cannot block the creator');
    }

    final participant = participants[participantIndex];
    if (participant.isBlocked) {
      throw Exception('Participant is already blocked');
    }

    // Unreserve all units reserved by this user
    final updatedUnits = units.map((unit) {
      if (unit.isReserved && unit.reservedBy == userId) {
        return unit.copyWith(
          status: UnitStatus.free,
          reservedBy: null,
          reservedByName: null,
          reservedDate: null,
        );
      }
      return unit;
    }).toList();

    final updatedParticipants = List<Participant>.from(participants);
    updatedParticipants[participantIndex] = participant.copyWith(
      status: ParticipantStatus.blocked,
    );

    return copyWith(
      participants: updatedParticipants,
      units: updatedUnits,
      lastActivityDate: DateTime.now(),
      lastActivityUserId: adminId,
      lastUpdated: DateTime.now(),
      needsSync: true,
    );
  }

  /// Remove a participant (admin only) - completely removes them from the list
  /// Only allowed if they have no completed units
  KhatmaShared removeParticipant(String userId, String adminId) {
    assertActive();

    // Check if admin has privileges
    if (!hasPrivileges(adminId)) {
      throw InsufficientPrivilegesException('remove participant');
    }

    // Check if participant exists
    if (!participants.any((p) => p.userId == userId)) {
      throw Exception('Participant not found');
    }

    // Cannot remove the creator
    if (userId == creatorId) {
      throw Exception('Cannot remove the creator');
    }

    // Check if participant has completed units
    final completedUnits = userCompletedUnits(userId);
    if (completedUnits.isNotEmpty) {
      throw Exception(
        'Cannot remove participant with completed units. Consider blocking instead.',
      );
    }

    // Unreserve all units reserved by this user
    final updatedUnits = units.map((unit) {
      if (unit.isReserved && unit.reservedBy == userId) {
        return unit.copyWith(
          status: UnitStatus.free,
          reservedBy: null,
          reservedByName: null,
          reservedDate: null,
        );
      }
      return unit;
    }).toList();

    final updatedParticipants = participants.where((p) => p.userId != userId).toList();

    return copyWith(
      participants: updatedParticipants,
      units: updatedUnits,
      lastActivityDate: DateTime.now(),
      lastActivityUserId: adminId,
      lastUpdated: DateTime.now(),
      needsSync: true,
    );
  }

  /// Get pending participants
  List<Participant> get pendingParticipants =>
      participants.where((p) => p.isPending).toList();

  /// Get approved participants
  List<Participant> get approvedParticipants =>
      participants.where((p) => p.isApproved).toList();

  /// Get blocked participants
  List<Participant> get blockedParticipants =>
      participants.where((p) => p.isBlocked).toList();

  KhatmaShared copyWith({
    KhatmaID? id,
    String? name,
    String? description,
    SplitUnit? unit,
    DateTime? createDate,
    DateTime? startDate,
    DateTime? endDate,
    KhatmaTheme? theme,
    KhatmaStatus? status,
    DateTime? lastUpdated,
    DateTime? lastSync,
    bool? needsSync,
    String? creatorId,
    String? creatorName,
    String? updatedBy,
    bool? repeat,
    int? repeats,
    int? version,
    SharedConfig? config,
    List<Participant>? participants,
    List<Unit>? units,
    DateTime? lastActivityDate,
    String? lastActivityUserId,
    double? progress,
  }) {
    return KhatmaShared(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      createDate: createDate ?? this.createDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      theme: theme ?? this.theme,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastSync: lastSync ?? this.lastSync,
      needsSync: needsSync ?? this.needsSync,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      updatedBy: updatedBy ?? this.updatedBy,
      repeat: repeat ?? this.repeat,
      repeats: repeats ?? this.repeats,
      version: version ?? this.version,
      config: config ?? this.config,
      participants: participants ?? this.participants,
      units: units ?? this.units,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      lastActivityUserId: lastActivityUserId ?? this.lastActivityUserId,
      progress: progress ?? this.progress,
    );
  }
}

// ============================================================================
// SHARED KHATMA - VALUE OBJECTS
// ============================================================================

/// Participant in shared khatma
class Participant {
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final DateTime joinedDate;
  final int completedUnits;
  final ParticipantRole role;
  final ParticipantStatus status;

  const Participant({
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.joinedDate,
    this.completedUnits = 0,
    this.role = ParticipantRole.member,
    this.status = ParticipantStatus.approved,
  });

  Participant copyWith({
    String? userId,
    String? userName,
    String? userPhotoUrl,
    DateTime? joinedDate,
    int? completedUnits,
    ParticipantRole? role,
    ParticipantStatus? status,
  }) {
    return Participant(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      joinedDate: joinedDate ?? this.joinedDate,
      completedUnits: completedUnits ?? this.completedUnits,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }

  // Helper getters
  bool get isPending => status == ParticipantStatus.pending;
  bool get isApproved => status == ParticipantStatus.approved;
  bool get isRejected => status == ParticipantStatus.rejected;
  bool get isBlocked => status == ParticipantStatus.blocked;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Participant && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}

/// Unit in shared khatma
class Unit {
  final int number;
  final UnitStatus status;
  final String? reservedBy;
  final String? reservedByName;
  final DateTime? reservedDate;
  final DateTime? completedDate;
  final String? completedBy;
  final String? completedByName;
  final DateTime? lastReminderSent;
  final int reminderCount;

  const Unit({
    required this.number,
    this.status = UnitStatus.free,
    this.reservedBy,
    this.reservedByName,
    this.reservedDate,
    this.completedDate,
    this.completedBy,
    this.completedByName,
    this.lastReminderSent,
    this.reminderCount = 0,
  });

  bool get isFree => status == UnitStatus.free;
  bool get isSelected => status == UnitStatus.selected;
  bool get isReserved => status == UnitStatus.reserved;
  bool get isCompleted => status == UnitStatus.completed;

  // Check if unit is reserved by a specific user
  bool isReservedBy(String userId) => reservedBy == userId;

  int? get daysSinceReserved {
    if (reservedDate == null) return null;
    return DateTime.now().difference(reservedDate!).inDays;
  }

  bool shouldShowWarning(int warningThresholdDays) {
    if (!isReserved) return false;
    final days = daysSinceReserved;
    return days != null && days >= warningThresholdDays;
  }

  bool hasExpired(int? expirationDays) {
    if (expirationDays == null) return false;
    if (!isReserved) return false;
    final days = daysSinceReserved;
    return days != null && days >= expirationDays;
  }

  bool get needsReminder {
    if (!isReserved) return false;
    if (lastReminderSent == null) return true;

    final daysSinceReminder = DateTime.now().difference(lastReminderSent!).inDays;
    return daysSinceReminder >= 3;
  }

  Unit copyWith({
    int? number,
    UnitStatus? status,
    String? reservedBy,
    String? reservedByName,
    DateTime? reservedDate,
    DateTime? completedDate,
    String? completedBy,
    String? completedByName,
    DateTime? lastReminderSent,
    int? reminderCount,
  }) {
    return Unit(
      number: number ?? this.number,
      status: status ?? this.status,
      reservedBy: reservedBy ?? this.reservedBy,
      reservedByName: reservedByName ?? this.reservedByName,
      reservedDate: reservedDate ?? this.reservedDate,
      completedDate: completedDate ?? this.completedDate,
      completedBy: completedBy ?? this.completedBy,
      completedByName: completedByName ?? this.completedByName,
      lastReminderSent: lastReminderSent ?? this.lastReminderSent,
      reminderCount: reminderCount ?? this.reminderCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Unit && other.number == number;
  }

  @override
  int get hashCode => number.hashCode;
}
