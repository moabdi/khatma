import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_theme.dart';

class KhatmaSharedMockData {
  static List<KhatmaShared> getMockKhatmas() {
    return [
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
}
