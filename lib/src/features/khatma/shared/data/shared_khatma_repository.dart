// lib/src/features/khatma/shared/data/shared_khatma_repository.dart
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';

/// Repository interface for shared Khatma operations
abstract interface class SharedKhatmaRepository {
  /// Save a new shared khatma to Firestore
  Future<Result<Khatma, AppErrorCode>> saveKhatma(Khatma khatma);

  /// Search for a shared khatma by its join code
  Future<Result<Khatma?, AppErrorCode>> searchByCode(String code);

  /// Join an existing shared khatma
  Future<Result<Khatma, AppErrorCode>> joinKhatma(
      String khatmaId, AppUser user);

  /// Leave a shared khatma
  Future<Result<void, AppErrorCode>> leaveKhatma(
      String khatmaId, String userId);

  /// Reserve/pick a part for reading
  Future<Result<KhatmaPart, AppErrorCode>> reservePart(
    String khatmaId,
    int partId,
    String userId,
    String userName,
  );

  /// Release a previously picked part
  Future<Result<void, AppErrorCode>> liberatePart(
    String khatmaId,
    int partId,
    String userId,
  );

  /// Mark a part as completed
  Future<Result<KhatmaPart, AppErrorCode>> completePart(
    String khatmaId,
    int partId,
    String userId,
  );

  /// Get all shared khatmas for a user
  Future<Result<List<Khatma>, AppErrorCode>> getUserSharedKhatmas(
      String userId);

  /// Get real-time updates for a specific shared khatma
  Stream<Result<Khatma, AppErrorCode>> watchKhatma(String khatmaId);

  /// Get participants of a shared khatma
  Future<Result<List<KhatmaParticipant>, AppErrorCode>> getParticipants(
      String khatmaId);

  /// Update khatma settings (only by owner)
  Future<Result<Khatma, AppErrorCode>> updateKhatma(
      Khatma khatma, String userId);

  /// Delete/archive a shared khatma (only by owner)
  Future<Result<void, AppErrorCode>> deleteKhatma(
      String khatmaId, String userId);
}

/// Participant information for shared khatmas
class KhatmaParticipant {
  final String userId;
  final String userName;
  final DateTime joinedAt;
  final int completedParts;
  final bool isOwner;

  const KhatmaParticipant({
    required this.userId,
    required this.userName,
    required this.joinedAt,
    required this.completedParts,
    this.isOwner = false,
  });

  factory KhatmaParticipant.fromMap(Map<String, dynamic> map) {
    return KhatmaParticipant(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      joinedAt: DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int),
      completedParts: map['completedParts'] as int? ?? 0,
      isOwner: map['isOwner'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'joinedAt': joinedAt.millisecondsSinceEpoch,
      'completedParts': completedParts,
      'isOwner': isOwner,
    };
  }
}
