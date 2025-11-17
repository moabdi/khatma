import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart';

part 'khatma_history_dto.freezed.dart';
part 'khatma_history_dto.g.dart';

@freezed
abstract class KhatmaHistoryDto with _$KhatmaHistoryDto {
  const factory KhatmaHistoryDto({
    String? id,
    KhatmaID? khatmaId,
    required DateTime startDate,
    required DateTime endDate,
    int? completionMode,
    String? completion,
    DateTime? lastSync,
    @Default(false) bool needsSync,
    @Default(false) bool isDeleted,
  }) = _KhatmaHistoryDto;

  factory KhatmaHistoryDto.fromJson(Map<String, Object?> json) =>
      _$KhatmaHistoryDtoFromJson(json);
}
