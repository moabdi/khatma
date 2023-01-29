import 'package:khatma_app/src/features/khatma/domain/khatma.dart';
import 'package:khatma_app/src/features/khatma/enums/khatma_enums.dart';

/// Test khatmat to be used until a data source is implemented
var kTestKhatmat = [
  Khatma(
    id: '1',
    name: 'Khatmati',
    description: '',
    type: KhatmaType.custom,
    unit: SplitUnit.juzz,
  ),
  Khatma(
    id: '2',
    name: 'Ramadan 2023',
    description: 'A l''ocasion de ramadan 2023',
    type: KhatmaType.ramadan,
    unit: SplitUnit.hizb,
  ),
  Khatma(
    id: '3',
    name: 'Khatma Monsuel',
    description: 'Hizeb raatib',
    type: KhatmaType.monthly,
    unit: SplitUnit.sourat,
  ),
  Khatma(
    id: '4',
    name: 'Mosquée plaisir',
    description: 'Comunité plaisir ',
    type: KhatmaType.mosque,
    unit: SplitUnit.quart,
  ),
  Khatma(
    id: '5',
    name: 'Khatma Joumouaa',
    description: 'Lecture chque vendredi',
    type: KhatmaType.friday,
    unit: SplitUnit.roubaa,
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
