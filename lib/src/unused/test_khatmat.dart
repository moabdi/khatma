import 'dart:math';

import 'package:khatma/src/features/khatma/presentation/extentions/khatma_extention.dart';
import 'package:khatma/src/features/khatma/presentation/form/ui/khatma_images.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:random_string/random_string.dart';

var random = Random();

/// Test khatmat to be used until a data source is implemented
var kTestKhatmat = [
  Khatma(
    code: randomAlphaNumeric(6),
    name: 'Khatmati hizb',
    description: 'test description',
    unit: SplitUnit.hizb,
    readParts: [
      KhatmaPart(id: 1, userName: "Ahmed", endDate: DateTime.now()),
      KhatmaPart(id: 2, userName: 'Ahmed', endDate: DateTime.now()),
      KhatmaPart(id: 3, userName: 'Ahmed', endDate: DateTime.now()),
    ],
    createDate: DateTime.parse("2022-12-26 13:27:00"),
    startDate: DateTime.parse("2022-12-26 13:27:00"),
    lastRead: DateTime.parse("2023-01-01 13:27:00"),
    endDate: DateTime.parse("2023-01-11 13:27:00"),
    recurrence: Recurrence(
      repeat: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)),
      days: List.empty(),
      unit: RepeatInterval.auto,
    ),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(
      visibility: ShareVisibility.public,
      maxPartToRead: 12,
      maxPartToReserve: 2,
    ),
  ),
];
var kTestKhatmats = [
  Khatma(
    id: '1',
    code: randomAlphaNumeric(6),
    name: 'Khatmati hizb',
    description: '',
    unit: SplitUnit.hizb,
    readParts: [
      KhatmaPart(id: 1, userName: "Ahmed", endDate: DateTime.now()),
      KhatmaPart(id: 2, userName: 'Ahmed', endDate: DateTime.now()),
      KhatmaPart(id: 3, userName: 'Ahmed', endDate: DateTime.now()),
    ],
    createDate: DateTime.parse("2022-12-26 13:27:00"),
    startDate: DateTime.parse("2022-12-26 13:27:00"),
    lastRead: DateTime.parse("2023-01-01 13:27:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.public),
  ),
  Khatma(
    id: '2',
    code: randomAlphaNumeric(6),
    name: 'Ramadan 2023',
    description: 'A l' 'ocasion de ramadan 2023',
    unit: SplitUnit.hizb,
    readParts: [
      KhatmaPart(
          id: 1, userName: 'Ahmed', endDate: DateTime.parse("2022-09-08")),
      KhatmaPart(
          id: 2, userName: 'Ahmed', endDate: DateTime.parse("2023-09-08")),
      KhatmaPart(
          id: 3, userName: 'Ahmed', endDate: DateTime.parse("2022-11-08")),
    ],
    createDate: DateTime.parse("2023-01-15 13:27:00"),
    startDate: DateTime.parse("2023-01-15 13:27:00"),
    lastRead: DateTime.parse("2023-02-08 08:00:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
  Khatma(
    id: '3',
    code: randomAlphaNumeric(6),
    name: 'Khatma Mensuel',
    description:
        'This code provides a basic setup to create two buttons. The first button is a filled button with an upgrade icon, and the second one is an outlined button with a heart icon. Adjustments can be made based on your exact design and requirements',
    unit: SplitUnit.hizb,
    readParts: [
      KhatmaPart(
          id: 1, userName: 'Ahmed', endDate: DateTime.parse("2022-09-08")),
      KhatmaPart(
          id: 2, userName: 'Ahmed', endDate: DateTime.parse("2023-09-08")),
      KhatmaPart(
          id: 3, userName: 'Ahmed', endDate: DateTime.parse("2022-11-08")),
    ],
    createDate: DateTime.parse("2023-01-01 10:15:00"),
    startDate: DateTime.parse("2023-01-01 10:15:00"),
    lastRead: DateTime.now(),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.group),
  ),
  Khatma(
    id: '4',
    code: randomAlphaNumeric(6),
    name: 'Mosquée plaisir',
    description: 'Comunité plaisir ',
    unit: SplitUnit.hizb,
    createDate: DateTime.parse("2022-12-01 10:15:00"),
    startDate: DateTime.parse("2022-12-01 10:15:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
  Khatma(
    id: '5',
    code: randomAlphaNumeric(6),
    name: 'Khatma Joumouaa',
    description: 'Lecture chque vendredi',
    unit: SplitUnit.hizb,
    createDate: DateTime.parse("2022-10-01 10:15:00"),
    startDate: DateTime.parse("2022-10-01 10:15:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
  Khatma(
    id: '6',
    code: randomAlphaNumeric(6),
    name: 'Khatma classique',
    description: 'Description classique',
    unit: SplitUnit.hizb,
    createDate: DateTime.parse("2022-11-01 10:15:00"),
    startDate: DateTime.parse("2022-11-01 10:15:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
  Khatma(
    id: '7',
    code: randomAlphaNumeric(6),
    name: 'Khatma 7',
    description: 'Description 7',
    unit: SplitUnit.juzz,
    createDate: DateTime.parse("2023-02-01 10:15:00"),
    startDate: DateTime.parse("2023-02-01 10:15:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
  Khatma(
    id: '8',
    code: randomAlphaNumeric(6),
    name: 'Khatma 8',
    description: 'Description 8',
    unit: SplitUnit.hizb,
    createDate: DateTime.parse("2022-12-01 10:15:00"),
    startDate: DateTime.parse("2022-12-01 10:15:00"),
    recurrence: Recurrence(
        repeat: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    theme: KhatmaTheme(
      color: khatmaColorHexList[random.nextInt(khatmaColorHexList.length)],
      icon: imagesNames[random.nextInt(imagesNames.length)],
    ),
    share: KhatmaShare(visibility: ShareVisibility.private),
  ),
];
