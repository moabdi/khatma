import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/domain/date_converter.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';

part 'khatma_history.freezed.dart';
part 'khatma_history.g.dart';

@freezed
class CompletionHistory with _$CompletionHistory {
  const factory CompletionHistory({
    KhatmaID? khatmaId,
    @DateConverter() required DateTime startDate,
    @DateConverter() required DateTime endDate,
  }) = _KhatmaHistory;

  factory CompletionHistory.fromJson(Map<String, Object?> json) =>
      _$CompletionHistoryFromJson(json);
}
