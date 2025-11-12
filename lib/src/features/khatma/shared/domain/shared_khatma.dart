// lib/src/features/shared_khatma/domain/shared_khatma.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma.dart';

part 'shared_khatma.freezed.dart';
part 'shared_khatma.g.dart';

typedef SharedKhatmaID = String;

@freezed
abstract class SharedKhatma with _$SharedKhatma {
  const SharedKhatma._();

  const factory SharedKhatma({
    SharedKhatmaID? id,
    required String name,
    required String description,
    required SplitUnit unit,
    required DateTime createDate,
    required String creatorId,
    String? creatorName,
    @Default(true) bool isPublic,
    @Default([]) List<SharedKhatmaParticipant> participants,
    @Default([]) List<SharedKhatmaUnit> units,
    DateTime? lastUpdated,
    @Default(SharedKhatmaStatus.active) SharedKhatmaStatus status,
    @Default(3) int maxReservationsPerUser,
    // Reservation timeout settings (in days)
    @Default(7) int reservationWarningDays, // Show warning after X days
    int? reservationExpirationDays, // Auto-free after X days (null = never expire)
  }) = _SharedKhatma;

  factory SharedKhatma.fromJson(Map<String, Object?> json) =>
      _$SharedKhatmaFromJson(json);

  // Computed properties
  int get membersCount => participants.length;

  int get unitsAvailable =>
      units.where((unit) => unit.status == UnitStatus.free).length;

  int get totalUnits => unit.count;

  List<SharedKhatmaUnit> get reservedUnits =>
      units.where((unit) => unit.status == UnitStatus.reserved).toList();

  List<SharedKhatmaUnit> get userReservedUnits => units
      .where((unit) => unit.status == UnitStatus.reservedByCurrentUser)
      .toList();

  // NEW: Check if user can reserve more units
  bool get canUserReserveMore =>
      userReservedUnits.length < maxReservationsPerUser;

  int get remainingReservations =>
      (maxReservationsPerUser - userReservedUnits.length)
          .clamp(0, maxReservationsPerUser);

  double get completionPercent {
    if (units.isEmpty) return 0.0;
    final completedCount =
        units.where((unit) => unit.status == UnitStatus.completed).length;
    return (completedCount / totalUnits).clamp(0.0, 1.0);
  }
}

@freezed
abstract class SharedKhatmaParticipant with _$SharedKhatmaParticipant {
  const factory SharedKhatmaParticipant({
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required DateTime joinedDate,
    @Default(0) int completedUnits,
    @Default(ParticipantRole.member) ParticipantRole role,
  }) = _SharedKhatmaParticipant;

  factory SharedKhatmaParticipant.fromJson(Map<String, Object?> json) =>
      _$SharedKhatmaParticipantFromJson(json);
}

@freezed
abstract class SharedKhatmaUnit with _$SharedKhatmaUnit {
  const SharedKhatmaUnit._();

  const factory SharedKhatmaUnit({
    required int unitNumber,
    @Default(UnitStatus.free) UnitStatus status,
    String? reservedByUserId,
    String? reservedByUserName,
    DateTime? reservedDate,
    DateTime? completedDate,
    DateTime? lastReminderSent, // Track when last reminder was sent
  }) = _SharedKhatmaUnit;

  factory SharedKhatmaUnit.fromJson(Map<String, Object?> json) =>
      _$SharedKhatmaUnitFromJson(json);

  bool get isFree => status == UnitStatus.free;
  bool get isSelected => status == UnitStatus.selected;
  bool get isReserved => status == UnitStatus.reserved;
  bool get isReservedByCurrentUser =>
      status == UnitStatus.reservedByCurrentUser;
  bool get isCompleted => status == UnitStatus.completed;

  /// Returns the number of days since this unit was reserved
  int? get daysSinceReserved {
    if (reservedDate == null) return null;
    return DateTime.now().difference(reservedDate!).inDays;
  }

  /// Check if this unit should show a warning (reserved too long)
  bool shouldShowWarning(int warningThresholdDays) {
    if (!isReserved && !isReservedByCurrentUser) return false;
    final days = daysSinceReserved;
    return days != null && days >= warningThresholdDays;
  }

  /// Check if this unit has expired and should be auto-freed
  bool hasExpired(int? expirationDays) {
    if (expirationDays == null) return false;
    if (!isReserved && !isReservedByCurrentUser) return false;
    final days = daysSinceReserved;
    return days != null && days >= expirationDays;
  }
}

enum SharedKhatmaStatus { active, completed, archived, deleted }

enum ParticipantRole { member, moderator, admin }

enum UnitStatus { free, reserved, selected, reservedByCurrentUser, completed }

// Mock data for testing
class SharedKhatmaMockData {
  static List<SharedKhatma> getMockKhatmas() {
    return [
      // Khatma with WARNING CASES - for testing overdue reservations
      SharedKhatma(
        id: '0',
        name: 'Test Khatma - Cas d\'Avertissements',
        description:
            'Khatma de test avec différents cas d\'avertissement de réservation en retard.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 30)),
        creatorId: 'creator1',
        creatorName: 'Ahmed Mohamed',
        isPublic: true,
        reservationWarningDays: 7, // Warning after 7 days
        reservationExpirationDays: 14, // Auto-expire after 14 days
        participants: [
          SharedKhatmaParticipant(
            userId: 'creator1',
            userName: 'Ahmed Mohamed',
            joinedDate: DateTime.now().subtract(const Duration(days: 30)),
            completedUnits: 3,
            role: ParticipantRole.admin,
          ),
          SharedKhatmaParticipant(
            userId: 'user2',
            userName: 'Fatima Ali',
            joinedDate: DateTime.now().subtract(const Duration(days: 25)),
            completedUnits: 1,
          ),
          SharedKhatmaParticipant(
            userId: 'user3',
            userName: 'Omar Hassan',
            joinedDate: DateTime.now().subtract(const Duration(days: 20)),
            completedUnits: 0,
          ),
        ],
        maxReservationsPerUser: 5,
        units: [
          // Unit 1: Reserved 20 days ago - EXPIRED (should be auto-freed)
          SharedKhatmaUnit(
            unitNumber: 1,
            status: UnitStatus.reserved,
            reservedByUserId: 'user2',
            reservedByUserName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 20)),
            lastReminderSent: DateTime.now().subtract(const Duration(days: 15)),
          ),
          // Unit 2: Reserved 15 days ago - VERY OVERDUE + EXPIRED
          SharedKhatmaUnit(
            unitNumber: 2,
            status: UnitStatus.reserved,
            reservedByUserId: 'user3',
            reservedByUserName: 'Omar Hassan',
            reservedDate: DateTime.now().subtract(const Duration(days: 15)),
          ),
          // Unit 3: Reserved 10 days ago - OVERDUE (warning shown)
          SharedKhatmaUnit(
            unitNumber: 3,
            status: UnitStatus.reserved,
            reservedByUserId: 'user2',
            reservedByUserName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 10)),
            lastReminderSent: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 4: Reserved 8 days ago - JUST OVERDUE (warning appears)
          SharedKhatmaUnit(
            unitNumber: 4,
            status: UnitStatus.reservedByCurrentUser,
            reservedByUserId: 'currentUser',
            reservedByUserName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 8)),
          ),
          // Unit 5: Reserved 6 days ago - OK (no warning yet)
          SharedKhatmaUnit(
            unitNumber: 5,
            status: UnitStatus.reserved,
            reservedByUserId: 'user3',
            reservedByUserName: 'Omar Hassan',
            reservedDate: DateTime.now().subtract(const Duration(days: 6)),
          ),
          // Unit 6: Reserved 3 days ago - OK (no warning)
          SharedKhatmaUnit(
            unitNumber: 6,
            status: UnitStatus.reservedByCurrentUser,
            reservedByUserId: 'currentUser',
            reservedByUserName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 7: Reserved 1 day ago - FRESH (no warning)
          SharedKhatmaUnit(
            unitNumber: 7,
            status: UnitStatus.reserved,
            reservedByUserId: 'user2',
            reservedByUserName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
          // Unit 8: Completed (no warning)
          SharedKhatmaUnit(
            unitNumber: 8,
            status: UnitStatus.completed,
            reservedByUserId: 'creator1',
            reservedByUserName: 'Ahmed Mohamed',
            reservedDate: DateTime.now().subtract(const Duration(days: 12)),
            completedDate: DateTime.now().subtract(const Duration(days: 5)),
          ),
          // Units 9-30: Free
          ...List.generate(22, (i) => SharedKhatmaUnit(unitNumber: i + 9)),
        ],
      ),
      SharedKhatma(
        id: '1',
        name: 'Khatma Ramadan 2024',
        description:
            'Khatma collective pour le mois de Ramadan. Rejoignez-nous pour une lecture partagée du Coran.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 7)),
        creatorId: 'creator1',
        creatorName: 'Ahmed Mohamed',
        isPublic: true,
        participants: [
          SharedKhatmaParticipant(
            userId: 'user1',
            userName: 'Ahmed Mohamed',
            joinedDate: DateTime.now().subtract(const Duration(days: 7)),
            completedUnits: 5,
            role: ParticipantRole.admin,
          ),
          SharedKhatmaParticipant(
            userId: 'user2',
            userName: 'Fatima Ali',
            joinedDate: DateTime.now().subtract(const Duration(days: 5)),
            completedUnits: 3,
          ),
          SharedKhatmaParticipant(
            userId: 'user3',
            userName: 'Omar Hassan',
            joinedDate: DateTime.now().subtract(const Duration(days: 3)),
            completedUnits: 2,
          ),
        ],
        maxReservationsPerUser: 5, // Limite de 5 unités par utilisateur
        units: List.generate(30, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 8) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: UnitStatus.completed,
              reservedByUserId: 'user${(unitNumber % 3) + 1}',
              reservedByUserName: [
                'Ahmed Mohamed',
                'Fatima Ali',
                'Omar Hassan'
              ][unitNumber % 3],
              reservedDate:
                  DateTime.now().subtract(Duration(days: 8 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 7 - unitNumber)),
            );
          } else if (unitNumber <= 12) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: unitNumber == 9
                  ? UnitStatus.reservedByCurrentUser
                  : UnitStatus.reserved,
              reservedByUserId: unitNumber == 9
                  ? 'currentUser'
                  : 'user${(unitNumber % 3) + 1}',
              reservedByUserName: unitNumber == 9
                  ? 'You'
                  : [
                      'Ahmed Mohamed',
                      'Fatima Ali',
                      'Omar Hassan'
                    ][unitNumber % 3],
              reservedDate:
                  DateTime.now().subtract(Duration(days: unitNumber - 8)),
            );
          } else {
            return SharedKhatmaUnit(unitNumber: unitNumber);
          }
        }),
      ),
      SharedKhatma(
        id: '2',
        name: 'Khatma Hebdomadaire',
        description:
            'Une khatma en mode Hizb pour une lecture hebdomadaire. Parfait pour maintenir une routine.',
        unit: SplitUnit.hizb,
        createDate: DateTime.now().subtract(const Duration(days: 14)),
        creatorId: 'creator2',
        creatorName: 'Khadija Benali',
        isPublic: true,
        participants: [
          SharedKhatmaParticipant(
            userId: 'creator2',
            userName: 'Khadija Benali',
            joinedDate: DateTime.now().subtract(const Duration(days: 14)),
            completedUnits: 12,
            role: ParticipantRole.admin,
          ),
          SharedKhatmaParticipant(
            userId: 'user4',
            userName: 'Youssef Amrani',
            joinedDate: DateTime.now().subtract(const Duration(days: 10)),
            completedUnits: 8,
          ),
        ],
        units: List.generate(60, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 20) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: UnitStatus.completed,
              reservedByUserId: unitNumber % 2 == 0 ? 'creator2' : 'user4',
              reservedByUserName:
                  unitNumber % 2 == 0 ? 'Khadija Benali' : 'Youssef Amrani',
              reservedDate:
                  DateTime.now().subtract(Duration(days: 25 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 24 - unitNumber)),
            );
          } else if (unitNumber <= 25) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: unitNumber == 21
                  ? UnitStatus.reservedByCurrentUser
                  : UnitStatus.reserved,
              reservedByUserId: unitNumber == 21 ? 'currentUser' : 'creator2',
              reservedByUserName: unitNumber == 21 ? 'You' : 'Khadija Benali',
              reservedDate:
                  DateTime.now().subtract(Duration(days: unitNumber - 20)),
            );
          } else {
            return SharedKhatmaUnit(unitNumber: unitNumber);
          }
        }),
      ),
      // Khatma with SHORT WARNING - for testing quick alerts
      SharedKhatma(
        id: '3',
        name: 'Test Khatma - Avertissements Rapides',
        description:
            'Khatma avec des durées courtes pour tester les avertissements rapides (2 jours warning, 4 jours expiration).',
        unit: SplitUnit.hizb,
        createDate: DateTime.now().subtract(const Duration(days: 10)),
        creatorId: 'creator3',
        creatorName: 'Khadija Test',
        isPublic: true,
        reservationWarningDays: 2, // Warning after 2 days
        reservationExpirationDays: 4, // Auto-expire after 4 days
        maxReservationsPerUser: 3,
        participants: [
          SharedKhatmaParticipant(
            userId: 'creator3',
            userName: 'Khadija Test',
            joinedDate: DateTime.now().subtract(const Duration(days: 10)),
            completedUnits: 2,
            role: ParticipantRole.admin,
          ),
          SharedKhatmaParticipant(
            userId: 'user7',
            userName: 'Test User',
            joinedDate: DateTime.now().subtract(const Duration(days: 5)),
            completedUnits: 0,
          ),
        ],
        units: [
          // Unit 1: Reserved 5 days ago - EXPIRED
          SharedKhatmaUnit(
            unitNumber: 1,
            status: UnitStatus.reserved,
            reservedByUserId: 'user7',
            reservedByUserName: 'Test User',
            reservedDate: DateTime.now().subtract(const Duration(days: 5)),
          ),
          // Unit 2: Reserved 3 days ago - OVERDUE
          SharedKhatmaUnit(
            unitNumber: 2,
            status: UnitStatus.reservedByCurrentUser,
            reservedByUserId: 'currentUser',
            reservedByUserName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 3: Reserved 1 day ago - OK
          SharedKhatmaUnit(
            unitNumber: 3,
            status: UnitStatus.reserved,
            reservedByUserId: 'user7',
            reservedByUserName: 'Test User',
            reservedDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
          // Units 4-20: Free
          ...List.generate(17, (i) => SharedKhatmaUnit(unitNumber: i + 4)),
        ],
      ),
      SharedKhatma(
        id: '4',
        name: 'Khatma Étudiants',
        description:
            'Khatma dédiée aux étudiants. Lecture flexible selon votre emploi du temps.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 3)),
        creatorId: 'creator4',
        creatorName: 'Amina Fassi',
        isPublic: true,
        participants: [
          SharedKhatmaParticipant(
            userId: 'creator4',
            userName: 'Amina Fassi',
            joinedDate: DateTime.now().subtract(const Duration(days: 3)),
            completedUnits: 2,
            role: ParticipantRole.admin,
          ),
          SharedKhatmaParticipant(
            userId: 'user5',
            userName: 'Said Rachid',
            joinedDate: DateTime.now().subtract(const Duration(days: 2)),
            completedUnits: 1,
          ),
          SharedKhatmaParticipant(
            userId: 'user6',
            userName: 'Nadia Benjelloun',
            joinedDate: DateTime.now().subtract(const Duration(days: 1)),
            completedUnits: 0,
          ),
        ],
        units: List.generate(30, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 3) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: UnitStatus.completed,
              reservedByUserId: 'creator3',
              reservedByUserName: 'Amina Fassi',
              reservedDate:
                  DateTime.now().subtract(Duration(days: 4 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 3 - unitNumber)),
            );
          } else if (unitNumber <= 5) {
            return SharedKhatmaUnit(
              unitNumber: unitNumber,
              status: UnitStatus.reserved,
              reservedByUserId: 'user5',
              reservedByUserName: 'Said Rachid',
              reservedDate:
                  DateTime.now().subtract(Duration(days: unitNumber - 3)),
            );
          } else {
            return SharedKhatmaUnit(unitNumber: unitNumber);
          }
        }),
      ),
    ];
  }
}
