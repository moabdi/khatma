import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:khatma/src/core/app_status.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/shared/data/shared_khatma_repository.dart';

part 'shared_khatma_state.freezed.dart';

@freezed
abstract class SharedKhatmaState with _$SharedKhatmaState {
  const factory SharedKhatmaState({
    @Default(AsyncValue.loading()) AsyncValue<List<Khatma>> sharedKhatmas,
    @Default(AsyncValue.loading())
    AsyncValue<List<KhatmaParticipant>> participants,
    AsyncValue<Khatma>? selectedKhatma,
    @Default(AppStatus.idle) AppStatus status,
    AppErrorCode? error,
    String? searchCode,
    Khatma? foundKhatma,
    Map<String, StreamSubscription>? khatmaStreams,
    @Default({}) Map<String, Khatma> watchedKhatmas,
  }) = _SharedKhatmaState;
}

/// Extension methods for SharedKhatmaState
extension SharedKhatmaStateX on SharedKhatmaState {
  List<Khatma> get sharedKhatmasOrEmpty => sharedKhatmas.valueOrNull ?? [];

  List<KhatmaParticipant> get participantsOrEmpty =>
      participants.valueOrNull ?? [];

  bool get isLoading =>
      status == AppStatus.loading || status == AppStatus.saving;

  bool get hasError => error != null;

  Khatma? getKhatmaById(String id) {
    return sharedKhatmasOrEmpty.cast<Khatma?>().firstWhere(
          (khatma) => khatma?.id == id,
          orElse: () => null,
        );
  }

  /// Get the latest version of a khatma (from watched or cached data)
  Khatma? getLatestKhatma(String id) {
    return watchedKhatmas[id] ?? getKhatmaById(id);
  }

  /// Check if user can perform actions on this khatma
  bool canUserModify(String khatmaId, String userId) {
    final participants = participantsOrEmpty;
    final userParticipant = participants.cast<KhatmaParticipant?>().firstWhere(
          (p) => p?.userId == userId,
          orElse: () => null,
        );
    return userParticipant?.isOwner == true;
  }

  /// Check if user is a participant in this khatma
  bool isUserParticipant(String khatmaId, String userId) {
    final participants = participantsOrEmpty;
    return participants.any((p) => p.userId == userId);
  }

  /// Get user's completion stats for a specific khatma
  int getUserCompletedParts(String khatmaId, String userId) {
    final participants = participantsOrEmpty;
    final userParticipant = participants.cast<KhatmaParticipant?>().firstWhere(
          (p) => p?.userId == userId,
          orElse: () => null,
        );
    return userParticipant?.completedParts ?? 0;
  }
}
