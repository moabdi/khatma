import 'dart:async';
import 'dart:math';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/core/result.dart';
import 'package:khatma/src/error/app_error_code.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/authentication/domain/app_user.dart';
import 'package:khatma/src/features/khatma/domain/khatma_domain.dart';
import 'package:khatma/src/features/khatma/shared/data/shared_khatma_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_shared_khatma_repository.g.dart';

@riverpod
SharedKhatmaRepository sharedKhatmaRepository(Ref ref) {
  return FirebaseSharedKhatmaRepository(
    firestore: FirebaseFirestore.instance,
    authRepository: ref.read(authRepositoryProvider),
  );
}

/// Firebase implementation of SharedKhatmaRepository with transaction safety
class FirebaseSharedKhatmaRepository implements SharedKhatmaRepository {
  final FirebaseFirestore _firestore;
  final AuthRepository _authRepository;

  static const String _khatmasCollection = 'shared_khatmas';
  static const String _participantsSubcollection = 'participants';

  FirebaseSharedKhatmaRepository({
    required FirebaseFirestore firestore,
    required AuthRepository authRepository,
  })  : _firestore = firestore,
        _authRepository = authRepository;

  @override
  Future<Result<Khatma, AppErrorCode>> saveKhatma(Khatma khatma) async {
    try {
      final user = await _authRepository.currentUser;
      if (user == null) {
        return const Result.failure(AppErrorCode.authUserNotFound);
      }

      // Generate unique code for the khatma
      final code = _generateUniqueCode();

      final khatmaToSave = khatma.copyWith(
        id: khatma.id ?? _firestore.collection(_khatmasCollection).doc().id,
        code: code,
        share: true,
        createDate: DateTime.now(),
        lastUpdated: DateTime.now(),
      );

      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaToSave.id);

        final participantRef =
            khatmaRef.collection(_participantsSubcollection).doc(user.uid);

        // Save khatma document
        transaction.set(khatmaRef, {
          ...khatmaToSave.toJson(),
          'ownerId': user.id,
          'ownerName': user.displayName ?? user.email ?? 'Unknown',
          'participantCount': 1,
        });

        // Add owner as first participant
        transaction.set(
            participantRef,
            KhatmaParticipant(
              userId: user.id,
              userName: user.displayName ?? user.email ?? 'Unknown',
              joinedAt: DateTime.now(),
              completedParts: 0,
              isOwner: true,
            ).toMap());
      });

      return Result.success(khatmaToSave);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<Khatma?, AppErrorCode>> searchByCode(String code) async {
    try {
      final querySnapshot = await _firestore
          .collection(_khatmasCollection)
          .where('code', isEqualTo: code)
          .where('status', isEqualTo: KhatmaStatus.active.name)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return const Result.success(null);
      }

      final doc = querySnapshot.docs.first;
      final khatma = Khatma.fromJson({...doc.data(), 'id': doc.id});
      return Result.success(khatma);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<Khatma, AppErrorCode>> joinKhatma(
      String khatmaId, AppUser user) async {
    try {
      late Khatma updatedKhatma;

      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final participantRef =
            khatmaRef.collection(_participantsSubcollection).doc(user.id);

        final khatmaDoc = await transaction.get(khatmaRef);
        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        final khatmaData = khatmaDoc.data()!;

        // Check if already a participant
        final participantDoc = await transaction.get(participantRef);
        /*
        if (participantDoc.exists) {
          return AppErrorCode.khatmaAlreadyJoined;
        }
        */
        // Add new participant
        transaction.set(
            participantRef,
            KhatmaParticipant(
              userId: user.id,
              userName: user.displayName ?? user.email ?? 'Unknown',
              joinedAt: DateTime.now(),
              completedParts: 0,
            ).toMap());

        // Update participant count
        final currentCount = khatmaData['participantCount'] as int? ?? 0;
        transaction.update(khatmaRef, {
          'participantCount': currentCount + 1,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        updatedKhatma = Khatma.fromJson({...khatmaData, 'id': khatmaId});
      });

      return Result.success(updatedKhatma);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<void, AppErrorCode>> leaveKhatma(
      String khatmaId, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final participantRef =
            khatmaRef.collection(_participantsSubcollection).doc(userId);

        final khatmaDoc = await transaction.get(khatmaRef);
        final participantDoc = await transaction.get(participantRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        /*
        if (!participantDoc.exists) {
          return AppErrorCode.khatmaNotJoined;
        }
        */

        final participantData = participantDoc.data()!;
        final isOwner = participantData['isOwner'] as bool? ?? false;

        /*
        if (isOwner) {
          AppErrorCode.khatmaOwnerCannotLeave;
        }
        */

        // Remove participant
        transaction.delete(participantRef);

        // Update participant count
        final khatmaData = khatmaDoc.data()!;
        final currentCount = khatmaData['participantCount'] as int? ?? 1;
        transaction.update(khatmaRef, {
          'participantCount': math.max(0, currentCount - 1),
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Release any parts reserved by this user
        final khatma = Khatma.fromJson({...khatmaData, 'id': khatmaId});
        final userParts = khatma.readParts
                ?.where((part) => part.userId == userId && !part.isCompleted)
                .toList() ??
            [];

        if (userParts.isNotEmpty) {
          final updatedParts = khatma.readParts?.map((part) {
                if (part.userId == userId && !part.isCompleted) {
                  return part.copyWith(
                    userId: null,
                    userName: null,
                    startDate: null,
                    status: KhatmaPartStatus.notStarted,
                  );
                }
                return part;
              }).toList() ??
              [];

          transaction.update(khatmaRef, {
            'readParts': updatedParts.map((part) => part.toJson()).toList(),
          });
        }
      });

      return const Result.success(null);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<KhatmaPart, AppErrorCode>> reservePart(
    String khatmaId,
    int partId,
    String userId,
    String userName,
  ) async {
    try {
      late KhatmaPart reservedPart;

      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final khatmaDoc = await transaction.get(khatmaRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        final khatmaData = khatmaDoc.data()!;
        final khatma = Khatma.fromJson({...khatmaData, 'id': khatmaId});

        // Check if part is available
        final existingPart = khatma.readParts?.firstWhere(
          (part) => part.id == partId,
          orElse: () => KhatmaPart(id: partId),
        );

        /*
        if (existingPart?.isCompleted == true) {
          return AppErrorCode.khatmaPartAlreadyCompleted;
        }

        if (existingPart?.userId != null && existingPart?.userId != userId) {
          return AppErrorCode.khatmaPartAlreadyReserved;
        }


        */

        // Create updated part
        reservedPart = KhatmaPart(
          id: partId,
          userId: userId,
          userName: userName,
          startDate: DateTime.now(),
          status: KhatmaPartStatus.reserved,
        );

        // Update parts list
        final updatedParts = List<KhatmaPart>.from(khatma.readParts ?? []);
        final existingIndex =
            updatedParts.indexWhere((part) => part.id == partId);

        if (existingIndex != -1) {
          updatedParts[existingIndex] = reservedPart;
        } else {
          updatedParts.add(reservedPart);
        }

        transaction.update(khatmaRef, {
          'readParts': updatedParts.map((part) => part.toJson()).toList(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      return Result.success(reservedPart);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<void, AppErrorCode>> liberatePart(
    String khatmaId,
    int partId,
    String userId,
  ) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final khatmaDoc = await transaction.get(khatmaRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        final khatmaData = khatmaDoc.data()!;
        final khatma = Khatma.fromJson({...khatmaData, 'id': khatmaId});

        final updatedParts = khatma.readParts?.map((part) {
              if (part.id == partId &&
                  part.userId == userId &&
                  !part.isCompleted) {
                return part.copyWith(
                  userId: null,
                  userName: null,
                  startDate: null,
                  status: KhatmaPartStatus.notStarted,
                );
              }
              return part;
            }).toList() ??
            [];

        transaction.update(khatmaRef, {
          'readParts': updatedParts.map((part) => part.toJson()).toList(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      return const Result.success(null);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<KhatmaPart, AppErrorCode>> completePart(
    String khatmaId,
    int partId,
    String userId,
  ) async {
    try {
      late KhatmaPart completedPart;

      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final participantRef =
            khatmaRef.collection(_participantsSubcollection).doc(userId);

        final khatmaDoc = await transaction.get(khatmaRef);
        final participantDoc = await transaction.get(participantRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        /*

        if (!participantDoc.exists) {
          return AppErrorCode.khatmaNotJoined;
        }
        */

        final khatmaData = khatmaDoc.data()!;
        final khatma = Khatma.fromJson({...khatmaData, 'id': khatmaId});

        final targetPart = khatma.readParts?.firstWhere(
          (part) => part.id == partId,
          orElse: () => KhatmaPart(id: partId),
        );

        /*
        if (targetPart?.isCompleted == true) {
          return AppErrorCode.khatmaPartAlreadyCompleted;
        }

        if (targetPart?.userId != null && targetPart?.userId != userId) {
          return AppErrorCode.khatmaPartNotReserved;
        }
      */
        // Create completed part
        completedPart = KhatmaPart(
          id: partId,
          userId: userId,
          userName: targetPart?.userName,
          startDate: targetPart?.startDate ?? DateTime.now(),
          endDate: DateTime.now(),
          finishedDate: DateTime.now(),
          status: KhatmaPartStatus.completed,
        );

        // Update parts list
        final updatedParts = List<KhatmaPart>.from(khatma.readParts ?? []);
        final existingIndex =
            updatedParts.indexWhere((part) => part.id == partId);

        if (existingIndex != -1) {
          updatedParts[existingIndex] = completedPart;
        } else {
          updatedParts.add(completedPart);
        }

        // Update participant stats
        final participantData = participantDoc.data()!;
        final currentCompleted = participantData['completedParts'] as int? ?? 0;

        transaction.update(participantRef, {
          'completedParts': currentCompleted + 1,
        });

        transaction.update(khatmaRef, {
          'readParts': updatedParts.map((part) => part.toJson()).toList(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      return Result.success(completedPart);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<List<Khatma>, AppErrorCode>> getUserSharedKhatmas(
      String userId) async {
    try {
      // Get all khatmas where user is a participant
      final participantQuery = await _firestore
          .collectionGroup(_participantsSubcollection)
          .where('userId', isEqualTo: userId)
          .get();

      final khatmaIds = participantQuery.docs
          .map((doc) => doc.reference.parent.parent!.id)
          .toList();

      if (khatmaIds.isEmpty) {
        return const Result.success([]);
      }

      // Firestore 'in' query has a limit of 10, so we need to batch if more
      final List<Khatma> allKhatmas = [];

      for (int i = 0; i < khatmaIds.length; i += 10) {
        final batch = khatmaIds.skip(i).take(10).toList();
        final khatmasQuery = await _firestore
            .collection(_khatmasCollection)
            .where(FieldPath.documentId, whereIn: batch)
            .where('status', isEqualTo: KhatmaStatus.active.name)
            .get();

        final khatmas = khatmasQuery.docs
            .map((doc) => Khatma.fromJson({...doc.data(), 'id': doc.id}))
            .toList();

        allKhatmas.addAll(khatmas);
      }

      return Result.success(allKhatmas);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Stream<Result<Khatma, AppErrorCode>> watchKhatma(String khatmaId) {
    return _firestore
        .collection(_khatmasCollection)
        .doc(khatmaId)
        .snapshots()
        .map((snapshot) {
      try {
        if (!snapshot.exists) {
          return const Result.failure(AppErrorCode.khatmaNotFound);
        }

        final khatma = Khatma.fromJson({
          ...snapshot.data()!,
          'id': snapshot.id,
        });

        return Result.success(khatma);
      } catch (e) {
        return Result.failure(_mapFirestoreErrorToAppError(e));
      }
    });
  }

  @override
  Future<Result<List<KhatmaParticipant>, AppErrorCode>> getParticipants(
      String khatmaId) async {
    try {
      final participantsQuery = await _firestore
          .collection(_khatmasCollection)
          .doc(khatmaId)
          .collection(_participantsSubcollection)
          .orderBy('joinedAt')
          .get();

      final participants = participantsQuery.docs
          .map((doc) => KhatmaParticipant.fromMap(doc.data()))
          .toList();

      return Result.success(participants);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<Khatma, AppErrorCode>> updateKhatma(
      Khatma khatma, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatma.id);
        final khatmaDoc = await transaction.get(khatmaRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        final khatmaData = khatmaDoc.data()!;
        final ownerId = khatmaData['ownerId'] as String?;

        if (ownerId != userId) {
          return AppErrorCode.permissionDenied;
        }

        transaction.update(khatmaRef, {
          ...khatma.toJson(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      return Result.success(khatma);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  @override
  Future<Result<void, AppErrorCode>> deleteKhatma(
      String khatmaId, String userId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final khatmaRef =
            _firestore.collection(_khatmasCollection).doc(khatmaId);
        final khatmaDoc = await transaction.get(khatmaRef);

        if (!khatmaDoc.exists) {
          return AppErrorCode.khatmaNotFound;
        }

        final khatmaData = khatmaDoc.data()!;
        final ownerId = khatmaData['ownerId'] as String?;

        if (ownerId != userId) {
          return AppErrorCode.permissionDenied;
        }

        transaction.update(khatmaRef, {
          'status': KhatmaStatus.deleted.name,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      return const Result.success(null);
    } catch (e) {
      return _handleFirestoreError(e);
    }
  }

  // Helper methods
  String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  Result<T, AppErrorCode> _handleFirestoreError<T>(Object error) {
    return Result.failure(_mapFirestoreErrorToAppError(error));
  }

  AppErrorCode _mapFirestoreErrorToAppError(Object error) {
    if (error is AppErrorCode) return error;

    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return AppErrorCode.permissionDenied;
        case 'not-found':
          return AppErrorCode.khatmaNotFound;
        case 'already-exists':
          return AppErrorCode.generalUnknown;
        case 'unavailable':
          return AppErrorCode.netConnectionFailed;
        case 'deadline-exceeded':
          return AppErrorCode.netTimeout;
        default:
          return AppErrorCode.generalUnknown;
      }
    }

    return AppErrorCode.generalUnknown;
  }
}
