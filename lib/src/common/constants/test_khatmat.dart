import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/presentation/common/khatma_images.dart';
import 'package:khatma/src/themes/theme.dart';

/// Test khatmat to be used until a data source is implemented
var kTestKhatmat = [
  Khatma(
    id: '1',
    name: 'Khatmati',
    description: '',
    unit: SplitUnit.juzz,
    completedParts: [1, 2, 3],
    createDate: DateTime.parse("2022-12-26 13:27:00"),
    lastRead: DateTime.parse("2023-01-01 13:27:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '2',
    name: 'Ramadan 2023',
    description: 'A l' 'ocasion de ramadan 2023',
    unit: SplitUnit.hizb,
    completedParts: [1, 2, 3, 4, 5],
    createDate: DateTime.parse("2023-01-15 13:27:00"),
    lastRead: DateTime.parse("2023-02-08 08:00:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '3',
    name: 'Khatma Mensuel',
    description: 'Hizeb raatib',
    unit: SplitUnit.sourat,
    completedParts: [1, 2],
    createDate: DateTime.parse("2023-01-01 10:15:00"),
    lastRead: DateTime.now(),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '4',
    name: 'Mosquée plaisir',
    description: 'Comunité plaisir ',
    unit: SplitUnit.rubue,
    createDate: DateTime.parse("2022-12-01 10:15:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '5',
    name: 'Khatma Joumouaa',
    description: 'Lecture chque vendredi',
    unit: SplitUnit.thumun,
    createDate: DateTime.parse("2022-10-01 10:15:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '6',
    name: 'Khatma classique',
    description: 'Description classique',
    unit: SplitUnit.sourat,
    createDate: DateTime.parse("2022-11-01 10:15:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '7',
    name: 'Khatma 7',
    description: 'Description 7',
    unit: SplitUnit.juzz,
    createDate: DateTime.parse("2023-02-01 10:15:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
  Khatma(
    id: '8',
    name: 'Khatma 8',
    description: 'Description 8',
    unit: SplitUnit.hizb,
    createDate: DateTime.parse("2022-12-01 10:15:00"),
    recurrence: Recurrence(
        scheduler: KhatmaScheduler.never,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365))),
    style: KhatmaStyle(
      color: AppTheme.getTheme().primaryColor.toString(),
      icon: khatmaImagesMap.entries.first.key,
    ),
    share: KhatmaShareType.private,
  ),
];
