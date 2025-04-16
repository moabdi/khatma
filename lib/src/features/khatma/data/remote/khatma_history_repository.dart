import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/khatma_history.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatma_history_repository.g.dart';

class KhatmaHistoryRepository {
  const KhatmaHistoryRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String historiesPath(String userUid) => 'users/$userUid/history';
  static String historyPath(String userUid, KhatmaID id) =>
      'users/$userUid/history/$id';

  Future<List<KhatmaHistory>> fetchKhatmasList(String userId) async {
    final ref = _khatmasRef(userId);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<KhatmaHistory>> watchKhatmasList(String userId) {
    final ref = _khatmasRef(userId);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<KhatmaHistory?> fetchKhatma(String userId, KhatmaID id) async {
    final ref = _khatmaRef(userId, id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<KhatmaHistory?> watchKhatma(String userId, KhatmaID id) {
    final ref = _khatmaRef(userId, id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future create(String userId, KhatmaHistory khatma) async {
    return _firestore.collection(historiesPath(userId)).add(khatma.toJson());
  }

  Future update(String userId, KhatmaHistory khatma) async {
    final ref = _khatmaRef(userId, khatma.id);
    return ref.set(khatma);
  }

  Future<void> deleteById(String userId, KhatmaID id) {
    return _firestore.doc(historyPath(userId, id)).delete();
  }

  DocumentReference<KhatmaHistory> _khatmaRef(String userId, KhatmaID id) =>
      _firestore.doc(historyPath(userId, id)).withConverter(
            fromFirestore: (doc, _) {
              final data = doc.data()!;
              data['id'] = doc.id;
              return KhatmaHistory.fromJson(data);
            },
            toFirestore: (KhatmaHistory khatma, options) => khatma.toJson(),
          );

  Query<KhatmaHistory> _khatmasRef(String userId) =>
      _firestore.collection(historiesPath(userId)).withConverter(
            fromFirestore: (doc, _) {
              final data = doc.data()!;
              data['id'] = doc.id;
              return KhatmaHistory.fromJson(data);
            },
            toFirestore: (KhatmaHistory khatmaHistory, options) =>
                khatmaHistory.toJson(),
          );
}

@Riverpod(keepAlive: true)
KhatmaHistoryRepository khatmaHistoryRepository(
    KhatmaHistoryRepositoryRef ref) {
  return KhatmaHistoryRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<KhatmaHistory>> khatmaHistoryRepositoryStream(
    KhatmaHistoryRepositoryStreamRef ref) {
  final khatmasRepository = ref.watch(khatmaHistoryRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatmasList(userUid);
}

@riverpod
Future<List<KhatmaHistory>> khatmaHistoryRepositoryFuture(
    KhatmaHistoryRepositoryFutureRef ref) {
  final khatmasRepository = ref.watch(khatmaHistoryRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatmasList(userUid);
}

@riverpod
Stream<KhatmaHistory?> khatmaHistoryStream(
    KhatmaHistoryStreamRef ref, KhatmaID id) {
  delay(true);
  final khatmasRepository = ref.watch(khatmaHistoryRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatma(userUid, id);
}

@riverpod
Future<KhatmaHistory?> khatmaHistoryFuture(
    KhatmaHistoryFutureRef ref, KhatmaID id) async {
  await delay(true, milliseconds: 100);
  final khatmasRepository = ref.watch(khatmaHistoryRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatma(userUid, id);
}
