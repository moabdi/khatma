import 'package:khatma/src/features/khatma/domain/models/khatma_enums.dart';
import 'package:khatma/src/features/khatma/domain/models/khatma_theme.dart';
import 'package:khatma/src/features/khatma/domain/models/khatma_exceptions.dart';

typedef KhatmaID = String;

// ============================================================================
// BASE KHATMA (SEALED CLASS)
// ============================================================================

sealed class Khatma {
  final KhatmaID? id;
  final KhatmaType type;
  final String code;
  final String name;
  final String? description;
  final SplitUnit unit;
  final DateTime createDate;
  final DateTime startDate;
  final DateTime? endDate;
  final KhatmaTheme theme;
  final KhatmaStatus status;
  final DateTime? lastUpdated;
  final DateTime? lastSync;
  final bool needsSync;
  final String? createdBy;
  final String? updatedBy;
  final int version;

  const Khatma({
    this.id,
    required this.type,
    required this.code,
    required this.name,
    this.description,
    required this.unit,
    required this.createDate,
    required this.startDate,
    this.endDate,
    required this.theme,
    required this.status,
    this.lastUpdated,
    this.lastSync,
    this.needsSync = false,
    this.createdBy,
    this.updatedBy,
    this.version = 1,
  });

  bool get isCompleted => status == KhatmaStatus.completed;
  bool get isActive => status == KhatmaStatus.active;
  bool get isDeleted => status == KhatmaStatus.deleted;

  bool get isPersonal => type == KhatmaType.personal;
  bool get isShared => type == KhatmaType.shared;
  bool get isHifz => type == KhatmaType.hifz;

  KhatmaTheme get effectiveTheme => theme;

  // Domain invariant checks
  void assertNotCompleted() {
    if (isCompleted) {
      throw const KhatmaCompletedException('Cannot modify a completed khatma');
    }
  }

  void assertNotDeleted() {
    if (isDeleted) {
      throw const KhatmaDeletedException('Cannot perform operations on a deleted khatma');
    }
  }

  void assertActive() {
    assertNotCompleted();
    assertNotDeleted();
  }

  // Domain method to increment version
  Khatma bumpVersion(String userId) {
    return switch (this) {
      PersonalKhatma k => k.copyWith(
          version: version + 1,
          updatedBy: userId,
          lastUpdated: DateTime.now(),
        ),
      SharedKhatma k => k.copyWith(
          version: version + 1,
          updatedBy: userId,
          lastUpdated: DateTime.now(),
        ),
      HifzKhatma k => k.copyWith(
          version: version + 1,
          updatedBy: userId,
          lastUpdated: DateTime.now(),
        ),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Khatma &&
        other.id == id &&
        other.type == type &&
        other.code == code;
  }

  @override
  int get hashCode => Object.hash(id, type, code);
}

// ============================================================================
// PERSONAL KHATMA
// ============================================================================

class PersonalKhatma extends Khatma {
  final List<int> completedParts;
  final bool repeat;
  final int repeats;
  final DateTime? lastRead;

  const PersonalKhatma({
    super.id,
    required super.code,
    required super.name,
    super.description,
    required super.unit,
    required super.createDate,
    required super.startDate,
    super.endDate,
    required super.theme,
    super.status = KhatmaStatus.active,
    super.lastUpdated,
    super.lastSync,
    super.needsSync = false,
    super.createdBy,
    super.updatedBy,
    super.version = 1,
    this.completedParts = const [],
    this.repeat = false,
    this.repeats = 0,
    this.lastRead,
  }) : super(type: KhatmaType.personal);

  // Computed properties
  double get completionPercent {
    if (completedParts.isEmpty) return 0.0;
    final uniqueCompleted = completedParts.toSet().length;
    return (uniqueCompleted / unit.count).clamp(0.0, 1.0);
  }

  Duration get duration {
    final baseDate = lastRead ?? createDate;
    return DateTime.now().difference(baseDate);
  }

  List<int> get completedPartIds => completedParts.toSet().toList();

  List<int> get remainingPartIds {
    final allParts = List.generate(unit.count, (index) => index + 1);
    final completed = completedParts.toSet();
    return allParts.where((part) => !completed.contains(part)).toList();
  }

  int get remainingPartsCount => remainingPartIds.length;

  // Helper method for updating reading progress with domain validation
  PersonalKhatma addCompletedParts(List<int> partIds) {
    // Domain invariant: Cannot modify completed or deleted khatma
    assertActive();

    // Validate part numbers
    for (final partId in partIds) {
      if (partId < 1 || partId > unit.count) {
        throw InvalidPartNumberException(partId, unit.count);
      }
    }

    // Check for duplicates in already completed parts
    final alreadyCompleted = completedParts.toSet();
    final duplicates = partIds.where((id) => alreadyCompleted.contains(id)).toList();
    if (duplicates.isNotEmpty) {
      throw DuplicatePartException(duplicates);
    }

    final now = DateTime.now();
    final updatedCompletedParts = [...completedParts, ...partIds];

    final updated = copyWith(
      completedParts: updatedCompletedParts,
      lastRead: now,
      lastUpdated: now,
      needsSync: true,
    );

    // Auto-complete if all parts are done
    if (updated.completionPercent >= 1.0 && status == KhatmaStatus.active) {
      return updated.copyWith(
        endDate: now,
        status: KhatmaStatus.completed,
      );
    }

    return updated;
  }

  PersonalKhatma copyWith({
    KhatmaID? id,
    String? code,
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
    String? createdBy,
    String? updatedBy,
    int? version,
    List<int>? completedParts,
    bool? repeat,
    int? repeats,
    DateTime? lastRead,
  }) {
    return PersonalKhatma(
      id: id ?? this.id,
      code: code ?? this.code,
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
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      completedParts: completedParts ?? this.completedParts,
      repeat: repeat ?? this.repeat,
      repeats: repeats ?? this.repeats,
      lastRead: lastRead ?? this.lastRead,
    );
  }
}

// ============================================================================
// SHARED KHATMA
// ============================================================================

/// Shared Khatma - Collaborative group reading
class SharedKhatma extends Khatma {
  final String creatorId;
  final String? creatorName;
  final bool isPublic;
  final String? inviteCode;
  final int maxReservationsPerUser;
  final int reservationWarningDays;
  final int? reservationExpirationDays;
  final bool autoReleaseExpiredReservations;
  final List<Participant> participants;
  final List<Unit> units;
  final DateTime? lastActivityDate;
  final String? lastActivityUserId;

  const SharedKhatma({
    super.id,
    required super.code,
    required super.name,
    super.description,
    required super.unit,
    required super.createDate,
    required super.startDate,
    super.endDate,
    required super.theme,
    super.status = KhatmaStatus.active,
    super.lastUpdated,
    super.lastSync,
    super.needsSync = false,
    super.createdBy,
    super.updatedBy,
    super.version = 1,
    required this.creatorId,
    this.creatorName,
    this.isPublic = true,
    this.inviteCode,
    this.maxReservationsPerUser = 3,
    this.reservationWarningDays = 7,
    this.reservationExpirationDays,
    this.autoReleaseExpiredReservations = true,
    this.participants = const [],
    this.units = const [],
    this.lastActivityDate,
    this.lastActivityUserId,
  }) : super(type: KhatmaType.shared);

  // Privilege checking helpers
  bool isCreator(String userId) => creatorId == userId;

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
      units.where((unit) => unit.reservedBy == userId).toList();

  // Check if user can reserve more units
  bool canUserReserveMore(String userId) =>
      userReservedUnits(userId).length < maxReservationsPerUser;

  // Get remaining reservations for a user
  int remainingReservations(String userId) =>
      (maxReservationsPerUser - userReservedUnits(userId).length)
          .clamp(0, maxReservationsPerUser);

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

    return unit.isFree || unit.reservedBy == userId;
  }

  // Domain methods for unit management
  SharedKhatma reserveUnit(int unitNumber, String userId, String userName) {
    assertActive();

    final unitIndex = units.indexWhere((u) => u.number == unitNumber);
    if (unitIndex == -1) {
      throw InvalidPartNumberException(unitNumber, totalUnits);
    }

    final unit = units[unitIndex];

    // Cannot reserve completed units
    if (unit.isCompleted) {
      throw UnitAlreadyCompletedException(unitNumber);
    }

    // Check if unit is already reserved by someone else
    if (unit.isReserved && unit.reservedBy != userId) {
      throw UnitAlreadyReservedException(unitNumber);
    }

    // Check reservation limit
    final userReserved = userReservedUnits(userId);
    if (userReserved.length >= maxReservationsPerUser) {
      throw ReservationLimitExceededException(maxReservationsPerUser);
    }

    final now = DateTime.now();
    final updatedUnits = List<Unit>.from(units);
    updatedUnits[unitIndex] = unit.copyWith(
      status: UnitStatus.reserved,
      reservedBy: userId,
      reservedByName: userName,
      reservedDate: now,
    );

    return copyWith(
      units: updatedUnits,
      lastActivityDate: now,
      lastActivityUserId: userId,
      lastUpdated: now,
      needsSync: true,
    );
  }

  SharedKhatma completeUnit(int unitNumber, String userId, String userName) {
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

  SharedKhatma releaseUnit(int unitNumber, String userId) {
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

  SharedKhatma copyWith({
    KhatmaID? id,
    String? code,
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
    String? createdBy,
    String? updatedBy,
    int? version,
    String? creatorId,
    String? creatorName,
    bool? isPublic,
    String? inviteCode,
    int? maxReservationsPerUser,
    int? reservationWarningDays,
    int? reservationExpirationDays,
    bool? autoReleaseExpiredReservations,
    List<Participant>? participants,
    List<Unit>? units,
    DateTime? lastActivityDate,
    String? lastActivityUserId,
  }) {
    return SharedKhatma(
      id: id ?? this.id,
      code: code ?? this.code,
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
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      isPublic: isPublic ?? this.isPublic,
      inviteCode: inviteCode ?? this.inviteCode,
      maxReservationsPerUser:
          maxReservationsPerUser ?? this.maxReservationsPerUser,
      reservationWarningDays:
          reservationWarningDays ?? this.reservationWarningDays,
      reservationExpirationDays:
          reservationExpirationDays ?? this.reservationExpirationDays,
      autoReleaseExpiredReservations:
          autoReleaseExpiredReservations ?? this.autoReleaseExpiredReservations,
      participants: participants ?? this.participants,
      units: units ?? this.units,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      lastActivityUserId: lastActivityUserId ?? this.lastActivityUserId,
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

  const Participant({
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.joinedDate,
    this.completedUnits = 0,
    this.role = ParticipantRole.member,
  });

  Participant copyWith({
    String? userId,
    String? userName,
    String? userPhotoUrl,
    DateTime? joinedDate,
    int? completedUnits,
    ParticipantRole? role,
  }) {
    return Participant(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      joinedDate: joinedDate ?? this.joinedDate,
      completedUnits: completedUnits ?? this.completedUnits,
      role: role ?? this.role,
    );
  }

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

// ============================================================================
// HIFZ KHATMA
// ============================================================================

/// Hifz Khatma - Quran memorization tracking
class HifzKhatma extends Khatma {
  final List<Section> sections;
  final HifzMode mode;
  final DateTime? lastRead;
  final int dailyGoal;
  final DateTime? targetCompletionDate;
  final RepeatInterval reviewInterval;
  final int reviewIntervalDays;

  const HifzKhatma({
    super.id,
    required super.code,
    required super.name,
    super.description,
    required super.unit,
    required super.createDate,
    required super.startDate,
    super.endDate,
    required super.theme,
    super.status = KhatmaStatus.active,
    super.lastUpdated,
    super.lastSync,
    super.needsSync = false,
    super.createdBy,
    super.updatedBy,
    super.version = 1,
    this.sections = const [],
    this.mode = HifzMode.memorization,
    this.lastRead,
    this.dailyGoal = 1,
    this.targetCompletionDate,
    this.reviewInterval = RepeatInterval.weekly,
    this.reviewIntervalDays = 7,
  }) : super(type: KhatmaType.hifz);

  // Computed properties
  double get completionPercent {
    if (sections.isEmpty) return 0.0;
    final masteredCount =
        sections.where((s) => s.status == HifzStatus.mastered).length;
    return (masteredCount / sections.length).clamp(0.0, 1.0);
  }

  int get sectionsMemorized =>
      sections.where((s) => s.status == HifzStatus.memorizing).length;

  int get sectionsReviewing =>
      sections.where((s) => s.status == HifzStatus.reviewing).length;

  int get sectionsMastered =>
      sections.where((s) => s.status == HifzStatus.mastered).length;

  List<Section> get sectionsDueForReview {
    if (reviewIntervalDays <= 0) return [];
    final now = DateTime.now();
    return sections.where((section) {
      if (section.lastReviewDate == null) return false;
      final daysSinceReview = now.difference(section.lastReviewDate!).inDays;
      return daysSinceReview >= reviewIntervalDays;
    }).toList();
  }

  List<Section> get weakSections {
    return sections.where((section) => section.isWeak).toList();
  }

  List<Section> get strongSections {
    return sections.where((section) => section.isStrong).toList();
  }

  double get averageConfidence {
    if (sections.isEmpty) return 0.0;
    final totalConfidence = sections.fold<double>(
      0.0,
      (sum, section) => sum + section.confidenceLevel,
    );
    return totalConfidence / sections.length;
  }

  bool get isOnTrack {
    if (targetCompletionDate == null) return true;
    if (sections.isEmpty) return true;

    final now = DateTime.now();
    final daysRemaining = targetCompletionDate!.difference(now).inDays;
    if (daysRemaining <= 0) return false;

    final sectionsRemaining = sections.length - sectionsMastered;
    final requiredDailyPace = sectionsRemaining / daysRemaining;

    return requiredDailyPace <= dailyGoal;
  }

  HifzKhatma copyWith({
    KhatmaID? id,
    String? code,
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
    String? createdBy,
    String? updatedBy,
    int? version,
    List<Section>? sections,
    HifzMode? mode,
    DateTime? lastRead,
    int? dailyGoal,
    DateTime? targetCompletionDate,
    RepeatInterval? reviewInterval,
    int? reviewIntervalDays,
  }) {
    return HifzKhatma(
      id: id ?? this.id,
      code: code ?? this.code,
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
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      sections: sections ?? this.sections,
      mode: mode ?? this.mode,
      lastRead: lastRead ?? this.lastRead,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      targetCompletionDate: targetCompletionDate ?? this.targetCompletionDate,
      reviewInterval: reviewInterval ?? this.reviewInterval,
      reviewIntervalDays: reviewIntervalDays ?? this.reviewIntervalDays,
    );
  }
}

// ============================================================================
// HIFZ KHATMA - VALUE OBJECTS
// ============================================================================

/// Section for hifz (memorization) tracking
class Section {
  final int id;
  final int startVerse;
  final int endVerse;
  final int surah;
  final HifzStatus status;
  final DateTime? startDate;
  final DateTime? masteredDate;
  final DateTime? lastReviewDate;
  final DateTime? nextReviewDate;
  final int reviewCount;
  final int mistakeCount;
  final int consecutiveSuccessfulReviews;
  final double confidenceLevel;

  const Section({
    required this.id,
    required this.startVerse,
    required this.endVerse,
    required this.surah,
    this.status = HifzStatus.notStarted,
    this.startDate,
    this.masteredDate,
    this.lastReviewDate,
    this.nextReviewDate,
    this.reviewCount = 0,
    this.mistakeCount = 0,
    this.consecutiveSuccessfulReviews = 0,
    this.confidenceLevel = 0.0,
  });

  bool get needsReview {
    if (nextReviewDate == null) return false;
    return DateTime.now().isAfter(nextReviewDate!);
  }

  bool get isStrong => confidenceLevel >= 0.8 && consecutiveSuccessfulReviews >= 3;
  bool get isWeak => confidenceLevel < 0.5 || mistakeCount > reviewCount * 0.3;

  Duration? get timeSinceLastReview {
    if (lastReviewDate == null) return null;
    return DateTime.now().difference(lastReviewDate!);
  }

  Section copyWith({
    int? id,
    int? startVerse,
    int? endVerse,
    int? surah,
    HifzStatus? status,
    DateTime? startDate,
    DateTime? masteredDate,
    DateTime? lastReviewDate,
    DateTime? nextReviewDate,
    int? reviewCount,
    int? mistakeCount,
    int? consecutiveSuccessfulReviews,
    double? confidenceLevel,
  }) {
    return Section(
      id: id ?? this.id,
      startVerse: startVerse ?? this.startVerse,
      endVerse: endVerse ?? this.endVerse,
      surah: surah ?? this.surah,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      masteredDate: masteredDate ?? this.masteredDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      reviewCount: reviewCount ?? this.reviewCount,
      mistakeCount: mistakeCount ?? this.mistakeCount,
      consecutiveSuccessfulReviews:
          consecutiveSuccessfulReviews ?? this.consecutiveSuccessfulReviews,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
