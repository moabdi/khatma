import 'package:khatma/src/features/khatma/data/model/completion_history_dto.dart';
import 'package:khatma/src/features/khatma/domain/models/completion_history.dart';
import 'package:khatma/src/features/khatma/domain/models/khatma_enums.dart';

/// Extension to map CompletionHistoryDto to Domain model
extension CompletionHistoryDtoMapper on CompletionHistoryDto {
  CompletionHistory toDomain() {
    return CompletionHistory(
      id: id,
      khatmaId: khatmaId,
      startDate: startDate,
      endDate: endDate,
      mode: _mapCompletionMode(completionMode),
      completion: completion,
    );
  }
}

/// Extension to map Domain model to DTO
extension CompletionHistoryDomainMapper on CompletionHistory {
  CompletionHistoryDto toDto({DateTime? lastSync, bool needsSync = false, bool isDeleted = false}) {
    return CompletionHistoryDto(
      id: id,
      khatmaId: khatmaId,
      startDate: startDate,
      endDate: endDate,
      completionMode: mode == CompletionMode.auto ? 0 : 1,
      completion: completion,
      lastSync: lastSync,
      needsSync: needsSync,
      isDeleted: isDeleted,
    );
  }
}

// Helper function
CompletionMode _mapCompletionMode(int? mode) {
  return (mode ?? 1) == 0 ? CompletionMode.auto : CompletionMode.manual;
}
