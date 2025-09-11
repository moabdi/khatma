import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma_domain.dart';

part 'khatma_state.freezed.dart';

@freezed
abstract class KhatmaState with _$KhatmaState {
  const factory KhatmaState({
    @Default(AsyncValue.loading()) AsyncValue<List<Khatma>> khatmas,
    @Default(AsyncValue.loading()) AsyncValue<List<CompletionHistory>> history,
    Khatma? selectedKhatma,
    @Default(AppStatus.idle) AppStatus status,
    AppErrorCode? error,
    SyncStatus? lastSyncStatus,
    @Default(0) int pendingSyncCount,
  }) = _KhatmaState;
}

extension KhatmaStateExtensions on AsyncValue<List<Khatma>> {
  List<Khatma> get valueOrEmpty => valueOrNull ?? [];
  int get totalCount => valueOrEmpty.length;
}
