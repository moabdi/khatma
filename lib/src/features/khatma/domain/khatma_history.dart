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
    int? completionMode,
    String? completion,
  }) = _CompletionHistory;

  factory CompletionHistory.fromJson(Map<String, Object?> json) =>
      _$CompletionHistoryFromJson(json);
}

enum CompletionMode {
  AUTO,
  MANUAL;
}

extension CompletionHistoryExtension on CompletionHistory {
  String? get partsRead {
    return completion?.split('/')[0];
  }

  String? get totalParts {
    return completion?.split('/')[1];
  }

  double get completionRatio {
    final read = partsRead;
    final total = totalParts;
    if (read == null || total == null || total == 0) return 1;
    return double.parse(completion!);
  }

  CompletionMode get mode {
    return (completionMode ?? 1) == 0
        ? CompletionMode.AUTO
        : CompletionMode.MANUAL;
  }
}
