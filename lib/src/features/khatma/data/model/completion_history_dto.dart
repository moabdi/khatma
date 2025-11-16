import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart';

part 'completion_history_dto.freezed.dart';
part 'completion_history_dto.g.dart';

@freezed
abstract class CompletionHistoryDto with _$CompletionHistoryDto {
  const factory CompletionHistoryDto({
    String? id,
    KhatmaID? khatmaId,
    required DateTime startDate,
    required DateTime endDate,
    int? completionMode,
    String? completion,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default(false) bool isDeleted,
  }) = _CompletionHistoryDto;

  factory CompletionHistoryDto.fromJson(Map<String, Object?> json) =>
      _$CompletionHistoryDtoFromJson(json);
}
