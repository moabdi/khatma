import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmas_repository.g.dart';

class KhatmasRepository {
  const KhatmasRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String khatmasPath(String userUid) => 'users/$userUid/khatmat';
  static String khatmaPath(String userUid, KhatmaID id) =>
      'users/$userUid/khatmat/$id';

  Future<List<Khatma>> fetchKhatmasList(String userId) async {
    if (kDebugMode) {
      debugPrint('[fetchKhatmasList] userId: $userId');
    }
    final ref = _khatmasRef(userId);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Khatma>> watchKhatmasList(String userId) {
    if (kDebugMode) {
      debugPrint('[watchKhatmasList] userId: $userId');
    }
    final ref = _khatmasRef(userId);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Khatma?> fetchKhatma(String userId, KhatmaID id) async {
    if (kDebugMode) {
      debugPrint('[fetchKhatma] userId: $userId, khatmaId: $id');
    }
    final ref = _khatmaRef(userId, id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Khatma?> watchKhatma(String userId, KhatmaID id) {
    if (kDebugMode) {
      debugPrint('[watchKhatma] userId: $userId, khatmaId: $id');
    }
    final ref = _khatmaRef(userId, id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<Khatma> create(String userId, Khatma khatma) async {
    if (kDebugMode) {
      debugPrint('[create] userId: $userId, khatma: ${khatma.name}');
    }
    final docRef =
        await _firestore.collection(khatmasPath(userId)).add(khatma.toJson());
    final newKhatma = khatma.copyWith(id: docRef.id);
    await docRef.set(newKhatma.toJson());
    return newKhatma;
  }

  Future<Khatma> update(String userId, Khatma khatma) async {
    if (kDebugMode) {
      debugPrint('[update] userId: $userId, khatma: ${khatma.name}');
    }
    final ref = _khatmaRef(userId, khatma.id!);
    await ref.set(khatma);
    return khatma;
  }

  Future<void> deleteById(String userId, KhatmaID id) {
    if (kDebugMode) {
      debugPrint('[deleteById] userId: $userId, khatmaId: $id');
    }
    return _firestore.doc(khatmaPath(userId, id)).delete();
  }

  DocumentReference<Khatma> _khatmaRef(String userId, KhatmaID id) {
    return _firestore.doc(khatmaPath(userId, id)).withConverter(
          fromFirestore: (doc, _) {
            final data = doc.data()!;
            data['id'] = doc.id;
            return Khatma.fromJson(data);
          },
          toFirestore: (Khatma khatma, options) => khatma.toJson(),
        );
  }

  Query<Khatma> _khatmasRef(String userId) {
    return _firestore.collection(khatmasPath(userId)).withConverter(
          fromFirestore: (doc, _) {
            final data = doc.data()!;
            data['id'] = doc.id;
            return Khatma.fromJson(data);
          },
          toFirestore: (Khatma khatma, options) => khatma.toJson(),
        );
  }

  Future<List<Khatma>> search(String userId, String query) async {
    if (kDebugMode) {
      debugPrint('[search] userId: $userId, query: "$query"');
    }
    final khatmasList = await fetchKhatmasList(userId);
    return khatmasList
        .where(
            (khatma) => khatma.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
KhatmasRepository khatmasRepository(KhatmasRepositoryRef ref) {
  return KhatmasRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Khatma>> khatmasListStream(KhatmasListStreamRef ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatmasList(userUid);
}

@riverpod
Future<List<Khatma>> khatmasListFuture(KhatmasListFutureRef ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatmasList(userUid);
}

@riverpod
Stream<Khatma?> khatmaStream(KhatmaStreamRef ref, KhatmaID id) {
  delay(true);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatma(userUid, id);
}

@riverpod
Future<Khatma?> khatmaFuture(KhatmaFutureRef ref, KhatmaID id) async {
  await delay(true, milliseconds: 100);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatma(userUid, id);
}
