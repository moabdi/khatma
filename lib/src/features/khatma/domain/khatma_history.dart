import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/domain/date_converter.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

part 'khatma_history.freezed.dart';
part 'khatma_history.g.dart';

typedef KhatmaID = String;

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
