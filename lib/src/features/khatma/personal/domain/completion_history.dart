import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma_ui/converters/date_converter.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma.dart';

part 'completion_history.freezed.dart';
part 'completion_history.g.dart';

@freezed
abstract class CompletionHistory with _$CompletionHistory {
  const factory CompletionHistory({
    String? id,
    KhatmaID? khatmaId,
    @DateConverter() required DateTime startDate,
    @DateConverter() required DateTime endDate,
    int? completionMode,
    String? completion,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default(false) bool isDeleted,
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
