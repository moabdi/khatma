import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
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
    print('[fetchKhatmasList] userId: $userId');
    final ref = _khatmasRef(userId);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Khatma>> watchKhatmasList(String userId) {
    print('[watchKhatmasList] userId: $userId');
    final ref = _khatmasRef(userId);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Khatma?> fetchKhatma(String userId, KhatmaID id) async {
    print('[fetchKhatma] userId: $userId, khatmaId: $id');
    final ref = _khatmaRef(userId, id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Khatma?> watchKhatma(String userId, KhatmaID id) {
    print('[watchKhatma] userId: $userId, khatmaId: $id');
    final ref = _khatmaRef(userId, id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<Khatma> create(String userId, Khatma khatma) async {
    print('[create] userId: $userId, khatma: ${khatma.name}');
    final docRef =
        await _firestore.collection(khatmasPath(userId)).add(khatma.toJson());
    final newKhatma = khatma.copyWith(id: docRef.id);
    await docRef.set(newKhatma.toJson());
    return newKhatma;
  }

  Future<Khatma> update(String userId, Khatma khatma) async {
    print('[update] userId: $userId, khatma: ${khatma.name}');
    final ref = _khatmaRef(userId, khatma.id!);
    await ref.set(khatma);
    return khatma;
  }

  Future<void> deleteById(String userId, KhatmaID id) {
    print('[deleteById] userId: $userId, khatmaId: $id');
    return _firestore.doc(khatmaPath(userId, id)).delete();
  }

  DocumentReference<Khatma> _khatmaRef(String userId, KhatmaID id) {
    //print('[_khatmaRef] userId: $userId, khatmaId: $id');
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
    //print('[_khatmasRef] userId: $userId');
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
    print('[search] userId: $userId, query: "$query"');
    final khatmasList = await fetchKhatmasList(userId);
    return khatmasList
        .where(
            (khatma) => khatma.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
KhatmasRepository khatmasRepository(KhatmasRepositoryRef ref) {
  print('[riverpod] khatmasRepository initialized');
  return KhatmasRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Khatma>> khatmasListStream(KhatmasListStreamRef ref) {
  print('[riverpod] khatmasListStream');
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatmasList(userUid);
}

@riverpod
Future<List<Khatma>> khatmasListFuture(KhatmasListFutureRef ref) {
  print('[riverpod] khatmasListFuture');
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatmasList(userUid);
}

@riverpod
Stream<Khatma?> khatmaStream(KhatmaStreamRef ref, KhatmaID id) {
  print('[riverpod] khatmaStream, khatmaId: $id');
  delay(true);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatma(userUid, id);
}

@riverpod
Future<Khatma?> khatmaFuture(KhatmaFutureRef ref, KhatmaID id) async {
  print('[riverpod] khatmaFuture, khatmaId: $id');
  await delay(true, milliseconds: 100);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatma(userUid, id);
}
