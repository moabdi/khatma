import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/domain/date_converter.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

part 'khatma_history.freezed.dart';
part 'khatma_history.g.dart';

@freezed
sealed class KhatmaHistory with _$KhatmaHistory {
  const factory KhatmaHistory.private({
    required KhatmaID id,
    required SplitUnit unit,
    @DateConverter() required DateTime startDate,
    @DateConverter() required DateTime endDate,
    required String userId,
    required List<KhatmaPartHistory> parts,
  }) = PrivateKhatmaHistory;

  const factory KhatmaHistory.shared({
    required KhatmaID id,
    required SplitUnit unit,
    @DateConverter() required DateTime startDate,
    @DateConverter() required DateTime endDate,
    required String userId,
    required Map<String, List<KhatmaPartHistory>> parts,
  }) = SharedKhatmaHistory;

  factory KhatmaHistory.fromJson(Map<String, Object?> json) =>
      _$KhatmaHistoryFromJson(json);

  static KhatmaHistory fromKhatma(Khatma khatma) {
    final startDate = khatma.recurrence.startDate;
    final endDate = khatma.recurrence.endDate;
    final unit = khatma.unit;

    if (khatma.share.visibility == ShareVisibility.private) {
      return KhatmaHistory.private(
        id: khatma.id!,
        unit: unit,
        startDate: startDate,
        endDate: endDate,
        userId: khatma.creator ?? "Unknown",
        parts: khatma.parts
                ?.where((p) => p.finishedDate != null)
                .map((p) =>
                    KhatmaPartHistory(id: p.id, endDate: p.finishedDate!))
                .toList() ??
            [],
      );
    } else {
      final sharedParts = <String, List<KhatmaPartHistory>>{};
      for (final part in khatma.parts ?? []) {
        if (part.userId != null && part.finishedDate != null) {
          sharedParts.putIfAbsent(part.userId!, () => []);
          sharedParts[part.userId!]!
              .add(KhatmaPartHistory(id: part.id, endDate: part.finishedDate!));
        }
      }

      return KhatmaHistory.shared(
        id: khatma.id!,
        unit: unit,
        startDate: startDate,
        endDate: endDate,
        userId: khatma.creator ?? "Unknown",
        parts: sharedParts,
      );
    }
  }
}

@freezed
class KhatmaPartHistory with _$KhatmaPartHistory {
  const factory KhatmaPartHistory({
    required int id,
    @DateConverter() required DateTime endDate,
  }) = _KhatmaPartHistory;

  factory KhatmaPartHistory.fromJson(Map<String, Object?> json) =>
      _$KhatmaPartHistoryFromJson(json);
}
