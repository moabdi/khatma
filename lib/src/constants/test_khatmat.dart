import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';

/// Test khatmat to be used until a data source is implemented
var kTestKhatmat = [
  Khatma(
    id: '1',
    name: 'Khatmati',
    description: '',
    type: KhatmaType.custom,
    unit: SplitUnit.juzz,
    completedParts: [1, 2, 3],
    lastRead: DateTime.parse("2023-01-01 13:27:00"),
  ),
  Khatma(
    id: '2',
    name: 'Ramadan 2023',
    description: 'A l' 'ocasion de ramadan 2023',
    type: KhatmaType.ramadan,
    unit: SplitUnit.hizb,
    completedParts: [1, 2, 3, 4, 5],
    lastRead: DateTime.parse("2023-02-08 08:00:00"),
  ),
  Khatma(
    id: '3',
    name: 'Khatma Mensuel',
    description: 'Hizeb raatib',
    type: KhatmaType.monthly,
    unit: SplitUnit.sourat,
    completedParts: [1, 2],
    lastRead: DateTime.now(),
  ),
  Khatma(
    id: '4',
    name: 'Mosquée plaisir',
    description: 'Comunité plaisir ',
    type: KhatmaType.mosque,
    unit: SplitUnit.rubue,
  ),
  Khatma(
    id: '5',
    name: 'Khatma Joumouaa',
    description: 'Lecture chque vendredi',
    type: KhatmaType.friday,
    unit: SplitUnit.thumun,
  ),
  Khatma(
    id: '6',
    name: 'Khatma classique',
    description: 'Description classique',
    unit: SplitUnit.hizb,
  ),
  Khatma(
    id: '7',
    name: 'Khatma 7',
    description: 'Description 7',
    unit: SplitUnit.hizb,
  ),
  Khatma(
    id: '8',
    name: 'Khatma 8',
    description: 'Description 8',
    unit: SplitUnit.hizb,
  ),
];
