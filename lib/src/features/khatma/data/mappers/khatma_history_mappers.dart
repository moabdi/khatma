import 'package:khatma/src/features/khatma/data/model/khatma_history_dto.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/features/khatma/domain/khatma_enums.dart';

/// Extension to map CompletionHistoryDto to Domain model
extension KhatmaHistoryDtoMapper on KhatmaHistoryDto {
  KhatmaHistory toDomain() {
    return KhatmaHistory(
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
extension CompletionHistoryDomainMapper on KhatmaHistory {
  KhatmaHistoryDto toDto({DateTime? lastSync, bool needsSync = false, bool isDeleted = false}) {
    return KhatmaHistoryDto(
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
