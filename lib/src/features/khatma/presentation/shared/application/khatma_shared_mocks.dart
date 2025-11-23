import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_theme.dart';

class KhatmaSharedMockData {
  static List<KhatmaShared> getMockKhatmas() {
    return [
      // COMPREHENSIVE TEST KHATMA - All filter cases clearly demonstrated
      _getTestAllFiltersKhatma(),
      // Khatma with WARNING CASES - for testing overdue reservations
      KhatmaShared(
        id: '0',
        code: 'MOCK-0',
        name: 'Test Khatma - Cas d\'Avertissements',
        description:
            'Khatma de test avec différents cas d\'avertissement de réservation en retard.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 30)),
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        theme: kDefaultKhatmaTheme,
        creatorId: 'creator1',
        creatorName: 'Ahmed Mohamed',
        participants: [
          Participant(
            userId: 'creator1',
            userName: 'Ahmed Mohamed',
            joinedDate: DateTime.now().subtract(const Duration(days: 30)),
            completedUnits: 3,
            role: ParticipantRole.admin,
          ),
          Participant(
            userId: 'user2',
            userName: 'Fatima Ali',
            joinedDate: DateTime.now().subtract(const Duration(days: 25)),
            completedUnits: 1,
          ),
          Participant(
            userId: 'user3',
            userName: 'Omar Hassan',
            joinedDate: DateTime.now().subtract(const Duration(days: 20)),
            completedUnits: 0,
          ),
        ],
        units: [
          // Unit 1: Reserved 20 days ago - EXPIRED (should be auto-freed)
          Unit(
            number: 1,
            status: UnitStatus.reserved,
            reservedBy: 'user2',
            reservedByName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 20)),
            lastReminderSent: DateTime.now().subtract(const Duration(days: 15)),
          ),
          // Unit 2: Reserved 15 days ago - VERY OVERDUE + EXPIRED
          Unit(
            number: 2,
            status: UnitStatus.reserved,
            reservedBy: 'user3',
            reservedByName: 'Omar Hassan',
            reservedDate: DateTime.now().subtract(const Duration(days: 15)),
          ),
          // Unit 3: Reserved 10 days ago - OVERDUE (warning shown)
          Unit(
            number: 3,
            status: UnitStatus.reserved,
            reservedBy: 'user2',
            reservedByName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 10)),
            lastReminderSent: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 4: Reserved 8 days ago - JUST OVERDUE (warning appears)
          Unit(
            number: 4,
            status: UnitStatus.reserved,
            reservedBy: 'currentUser',
            reservedByName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 8)),
          ),
          // Unit 5: Reserved 6 days ago - OK (no warning yet)
          Unit(
            number: 5,
            status: UnitStatus.reserved,
            reservedBy: 'user3',
            reservedByName: 'Omar Hassan',
            reservedDate: DateTime.now().subtract(const Duration(days: 6)),
          ),
          // Unit 6: Reserved 3 days ago - OK (no warning)
          Unit(
            number: 6,
            status: UnitStatus.reserved,
            reservedBy: 'currentUser',
            reservedByName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 7: Reserved 1 day ago - FRESH (no warning)
          Unit(
            number: 7,
            status: UnitStatus.reserved,
            reservedBy: 'user2',
            reservedByName: 'Fatima Ali',
            reservedDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
          // Unit 8: Completed (no warning)
          Unit(
            number: 8,
            status: UnitStatus.completed,
            reservedBy: 'creator1',
            reservedByName: 'Ahmed Mohamed',
            reservedDate: DateTime.now().subtract(const Duration(days: 12)),
            completedDate: DateTime.now().subtract(const Duration(days: 5)),
            completedBy: 'creator1',
            completedByName: 'Ahmed Mohamed',
          ),
          // Units 9-30: Free
          ...List.generate(22, (i) => Unit(number: i + 9)),
        ],
      ),
      KhatmaShared(
        id: '1',
        code: 'MOCK-1',
        name: 'Khatma Ramadan 2024',
        description:
            'Khatma collective pour le mois de Ramadan. Rejoignez-nous pour une lecture partagée du Coran.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 7)),
        startDate: DateTime.now().subtract(const Duration(days: 7)),
        theme: kDefaultKhatmaTheme,
        creatorId: 'creator1',
        creatorName: 'Ahmed Mohamed',
        config: const SharedConfig.defaults(),
        participants: [
          Participant(
            userId: 'user1',
            userName: 'Ahmed Mohamed',
            joinedDate: DateTime.now().subtract(const Duration(days: 7)),
            completedUnits: 5,
            role: ParticipantRole.admin,
          ),
          Participant(
            userId: 'user2',
            userName: 'Fatima Ali',
            joinedDate: DateTime.now().subtract(const Duration(days: 5)),
            completedUnits: 3,
          ),
          Participant(
            userId: 'user3',
            userName: 'Omar Hassan',
            joinedDate: DateTime.now().subtract(const Duration(days: 3)),
            completedUnits: 2,
          ),
        ],
        units: List.generate(30, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 8) {
            final userId = 'user${(unitNumber % 3) + 1}';
            final userName = [
              'Ahmed Mohamed',
              'Fatima Ali',
              'Omar Hassan'
            ][unitNumber % 3];
            return Unit(
              number: unitNumber,
              status: UnitStatus.completed,
              reservedBy: userId,
              reservedByName: userName,
              reservedDate:
                  DateTime.now().subtract(Duration(days: 8 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 7 - unitNumber)),
              completedBy: userId,
              completedByName: userName,
            );
          } else if (unitNumber <= 12) {
            return Unit(
              number: unitNumber,
              status: UnitStatus.reserved,
              reservedBy: unitNumber == 9
                  ? 'currentUser'
                  : 'user${(unitNumber % 3) + 1}',
              reservedByName: unitNumber == 9
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
            return Unit(number: unitNumber);
          }
        }),
      ),
      KhatmaShared(
        id: '2',
        code: 'MOCK-2',
        name: 'Khatma Hebdomadaire',
        description:
            'Une khatma en mode Hizb pour une lecture hebdomadaire. Parfait pour maintenir une routine.',
        unit: SplitUnit.hizb,
        createDate: DateTime.now().subtract(const Duration(days: 14)),
        startDate: DateTime.now().subtract(const Duration(days: 14)),
        theme: kDefaultKhatmaTheme,
        creatorId: 'creator2',
        creatorName: 'Khadija Benali',
        config: const SharedConfig.defaults(),
        participants: [
          Participant(
            userId: 'creator2',
            userName: 'Khadija Benali',
            joinedDate: DateTime.now().subtract(const Duration(days: 14)),
            completedUnits: 12,
            role: ParticipantRole.admin,
          ),
          Participant(
            userId: 'user4',
            userName: 'Youssef Amrani',
            joinedDate: DateTime.now().subtract(const Duration(days: 10)),
            completedUnits: 8,
          ),
        ],
        units: List.generate(60, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 20) {
            final userId = unitNumber % 2 == 0 ? 'creator2' : 'user4';
            final userName = unitNumber % 2 == 0 ? 'Khadija Benali' : 'Youssef Amrani';
            return Unit(
              number: unitNumber,
              status: UnitStatus.completed,
              reservedBy: userId,
              reservedByName: userName,
              reservedDate:
                  DateTime.now().subtract(Duration(days: 25 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 24 - unitNumber)),
              completedBy: userId,
              completedByName: userName,
            );
          } else if (unitNumber <= 25) {
            return Unit(
              number: unitNumber,
              status: UnitStatus.reserved,
              reservedBy: unitNumber == 21 ? 'currentUser' : 'creator2',
              reservedByName: unitNumber == 21 ? 'You' : 'Khadija Benali',
              reservedDate:
                  DateTime.now().subtract(Duration(days: unitNumber - 20)),
            );
          } else {
            return Unit(number: unitNumber);
          }
        }),
      ),
      // Khatma with SHORT WARNING - for testing quick alerts
      KhatmaShared(
        id: '3',
        code: 'MOCK-3',
        name: 'Test Khatma - Avertissements Rapides',
        description:
            'Khatma avec des durées courtes pour tester les avertissements rapides (2 jours warning, 4 jours expiration).',
        unit: SplitUnit.hizb,
        createDate: DateTime.now().subtract(const Duration(days: 10)),
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        theme: kDefaultKhatmaTheme,
        creatorId: 'creator3',
        creatorName: 'Khadija Test',

        participants: [
          Participant(
            userId: 'creator3',
            userName: 'Khadija Test',
            joinedDate: DateTime.now().subtract(const Duration(days: 10)),
            completedUnits: 2,
            role: ParticipantRole.admin,
          ),
          Participant(
            userId: 'user7',
            userName: 'Test User',
            joinedDate: DateTime.now().subtract(const Duration(days: 5)),
            completedUnits: 0,
          ),
        ],
        units: [
          // Unit 1: Reserved 5 days ago - EXPIRED
          Unit(
            number: 1,
            status: UnitStatus.reserved,
            reservedBy: 'user7',
            reservedByName: 'Test User',
            reservedDate: DateTime.now().subtract(const Duration(days: 5)),
          ),
          // Unit 2: Reserved 3 days ago - OVERDUE
          Unit(
            number: 2,
            status: UnitStatus.reserved,
            reservedBy: 'currentUser',
            reservedByName: 'Vous',
            reservedDate: DateTime.now().subtract(const Duration(days: 3)),
          ),
          // Unit 3: Reserved 1 day ago - OK
          Unit(
            number: 3,
            status: UnitStatus.reserved,
            reservedBy: 'user7',
            reservedByName: 'Test User',
            reservedDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
          // Units 4-20: Free
          ...List.generate(17, (i) => Unit(number: i + 4)),
        ],
      ),
      KhatmaShared(
        id: '4',
        code: 'MOCK-4',
        name: 'Khatma Étudiants',
        description:
            'Khatma dédiée aux étudiants. Lecture flexible selon votre emploi du temps.',
        unit: SplitUnit.juzz,
        createDate: DateTime.now().subtract(const Duration(days: 3)),
        startDate: DateTime.now().subtract(const Duration(days: 3)),
        theme: kDefaultKhatmaTheme,
        creatorId: 'creator4',
        creatorName: 'Amina Fassi',
        config: const SharedConfig.defaults(),
        participants: [
          Participant(
            userId: 'creator4',
            userName: 'Amina Fassi',
            joinedDate: DateTime.now().subtract(const Duration(days: 3)),
            completedUnits: 2,
            role: ParticipantRole.admin,
          ),
          Participant(
            userId: 'user5',
            userName: 'Said Rachid',
            joinedDate: DateTime.now().subtract(const Duration(days: 2)),
            completedUnits: 1,
          ),
          Participant(
            userId: 'user6',
            userName: 'Nadia Benjelloun',
            joinedDate: DateTime.now().subtract(const Duration(days: 1)),
            completedUnits: 0,
          ),
        ],
        units: List.generate(30, (index) {
          final unitNumber = index + 1;
          if (unitNumber <= 3) {
            return Unit(
              number: unitNumber,
              status: UnitStatus.completed,
              reservedBy: 'creator4',
              reservedByName: 'Amina Fassi',
              reservedDate:
                  DateTime.now().subtract(Duration(days: 4 - unitNumber)),
              completedDate:
                  DateTime.now().subtract(Duration(days: 3 - unitNumber)),
              completedBy: 'creator4',
              completedByName: 'Amina Fassi',
            );
          } else if (unitNumber <= 5) {
            return Unit(
              number: unitNumber,
              status: UnitStatus.reserved,
              reservedBy: 'user5',
              reservedByName: 'Said Rachid',
              reservedDate:
                  DateTime.now().subtract(Duration(days: unitNumber - 3)),
            );
          } else {
            return Unit(number: unitNumber);
          }
        }),
      ),
    ];
  }

  /// Comprehensive test khatma demonstrating all filter cases
  static KhatmaShared _getTestAllFiltersKhatma() {
    return KhatmaShared(
      id: 'test-all-filters',
      code: 'TEST-FILTERS',
      name: '🧪 Test All Filters - Demo Khatma',
      description:
          'This khatma demonstrates all possible unit states and filter cases. Use the filter chips to see different unit groups:\n\n'
          '• All (60): Shows everything\n'
          '• Mine (10): Units reserved/completed by you\n'
          '• Free (35): Available units\n'
          '• Reserved (15): All reserved units\n'
          '• Completed (10): Finished units',
      unit: SplitUnit.hizb,
      createDate: DateTime.now().subtract(const Duration(days: 15)),
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      theme: const KhatmaTheme(
        icon: '📚',
        color: '#0F65E6', // Blue color
      ),
      creatorId: 'demo-admin',
      creatorName: 'Demo Admin',
      participants: [
        Participant(
          userId: 'demo-admin',
          userName: 'Demo Admin',
          joinedDate: DateTime.now().subtract(const Duration(days: 15)),
          completedUnits: 5,
          role: ParticipantRole.admin,
        ),
        Participant(
          userId: 'currentUser',
          userName: 'You',
          joinedDate: DateTime.now().subtract(const Duration(days: 10)),
          completedUnits: 5,
          role: ParticipantRole.member,
        ),
        Participant(
          userId: 'user-alice',
          userName: 'Alice',
          joinedDate: DateTime.now().subtract(const Duration(days: 12)),
          completedUnits: 3,
        ),
        Participant(
          userId: 'user-bob',
          userName: 'Bob',
          joinedDate: DateTime.now().subtract(const Duration(days: 8)),
          completedUnits: 2,
        ),
      ],
      units: [
        // === COMPLETED UNITS (1-10) ===
        // Mine - Completed (1-5)
        ...List.generate(5, (i) {
          final num = i + 1;
          return Unit(
            number: num,
            status: UnitStatus.completed,
            reservedBy: 'currentUser',
            reservedByName: 'You',
            reservedDate: DateTime.now().subtract(Duration(days: 15 - i)),
            completedDate: DateTime.now().subtract(Duration(days: 10 - i)),
            completedBy: 'currentUser',
            completedByName: 'You',
          );
        }),
        // Others - Completed (6-10)
        Unit(
          number: 6,
          status: UnitStatus.completed,
          reservedBy: 'demo-admin',
          reservedByName: 'Demo Admin',
          reservedDate: DateTime.now().subtract(const Duration(days: 12)),
          completedDate: DateTime.now().subtract(const Duration(days: 8)),
          completedBy: 'demo-admin',
          completedByName: 'Demo Admin',
        ),
        Unit(
          number: 7,
          status: UnitStatus.completed,
          reservedBy: 'user-alice',
          reservedByName: 'Alice',
          reservedDate: DateTime.now().subtract(const Duration(days: 11)),
          completedDate: DateTime.now().subtract(const Duration(days: 7)),
          completedBy: 'user-alice',
          completedByName: 'Alice',
        ),
        Unit(
          number: 8,
          status: UnitStatus.completed,
          reservedBy: 'user-bob',
          reservedByName: 'Bob',
          reservedDate: DateTime.now().subtract(const Duration(days: 10)),
          completedDate: DateTime.now().subtract(const Duration(days: 6)),
          completedBy: 'user-bob',
          completedByName: 'Bob',
        ),
        Unit(
          number: 9,
          status: UnitStatus.completed,
          reservedBy: 'demo-admin',
          reservedByName: 'Demo Admin',
          reservedDate: DateTime.now().subtract(const Duration(days: 9)),
          completedDate: DateTime.now().subtract(const Duration(days: 5)),
          completedBy: 'demo-admin',
          completedByName: 'Demo Admin',
        ),
        Unit(
          number: 10,
          status: UnitStatus.completed,
          reservedBy: 'user-alice',
          reservedByName: 'Alice',
          reservedDate: DateTime.now().subtract(const Duration(days: 8)),
          completedDate: DateTime.now().subtract(const Duration(days: 4)),
          completedBy: 'user-alice',
          completedByName: 'Alice',
        ),

        // === RESERVED UNITS (11-25) ===
        // Mine - Reserved (11-15) - Various ages to show overdue warnings
        Unit(
          number: 11,
          status: UnitStatus.reserved,
          reservedBy: 'currentUser',
          reservedByName: 'You',
          reservedDate: DateTime.now().subtract(const Duration(days: 10)),
          // OVERDUE - 10 days old
        ),
        Unit(
          number: 12,
          status: UnitStatus.reserved,
          reservedBy: 'currentUser',
          reservedByName: 'You',
          reservedDate: DateTime.now().subtract(const Duration(days: 8)),
          // OVERDUE - 8 days old
        ),
        Unit(
          number: 13,
          status: UnitStatus.reserved,
          reservedBy: 'currentUser',
          reservedByName: 'You',
          reservedDate: DateTime.now().subtract(const Duration(days: 5)),
          // OK - 5 days old
        ),
        Unit(
          number: 14,
          status: UnitStatus.reserved,
          reservedBy: 'currentUser',
          reservedByName: 'You',
          reservedDate: DateTime.now().subtract(const Duration(days: 2)),
          // FRESH - 2 days old
        ),
        Unit(
          number: 15,
          status: UnitStatus.reserved,
          reservedBy: 'currentUser',
          reservedByName: 'You',
          reservedDate: DateTime.now().subtract(const Duration(hours: 12)),
          // VERY FRESH - 12 hours old
        ),
        // Others - Reserved (16-25)
        ...List.generate(10, (i) {
          final num = 16 + i;
          final users = [
            ('demo-admin', 'Demo Admin'),
            ('user-alice', 'Alice'),
            ('user-bob', 'Bob'),
          ];
          final user = users[i % 3];
          return Unit(
            number: num,
            status: UnitStatus.reserved,
            reservedBy: user.$1,
            reservedByName: user.$2,
            reservedDate: DateTime.now().subtract(Duration(days: 10 - i)),
          );
        }),

        // === FREE UNITS (26-60) ===
        ...List.generate(35, (i) => Unit(number: 26 + i)),
      ],
    );
  }
}
