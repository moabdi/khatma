import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmas_repository.g.dart';

class KhatmasRepository {
  const KhatmasRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String khatmasPath() => 'khatmas';
  static String khatmaPath(KhatmaID id) =>
      'khatmas/${FirebaseAuth.instance.currentUser!.uid}/$id';

  Future<List<Khatma>> fetchKhatmasList() async {
    final ref = _khatmasRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Khatma>> watchKhatmasList() {
    final ref = _khatmasRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Khatma?> fetchKhatma(KhatmaID id) async {
    final ref = _khatmaRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Khatma?> watchKhatma(KhatmaID id) {
    final ref = _khatmaRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<void> createKhatma(KhatmaID id, String imageUrl) {
    print(_firestore.databaseId);
    return _firestore.doc(khatmaPath(id)).set(
      {
        'id': id,
        'imageUrl': imageUrl,
      },
      // use merge: true to keep old fields (if any)
      SetOptions(merge: true),
    );
  }

  Future<Future<DocumentReference<Map<String, dynamic>>>> addKhatma(
      Khatma khatma) async {
    print(FirebaseAuth.instance.currentUser);
    return _firestore
        .collection('users/${FirebaseAuth.instance.currentUser!.uid}/khatmat')
        .add(khatma.toJson());
  }

  Future<void> updateKhatma(Khatma khatma) {
    final ref = _khatmaRef(khatma.id!);
    return ref.set(khatma);
  }

  Future<void> deleteKhatma(KhatmaID id) {
    return _firestore.doc(khatmaPath(id)).delete();
  }

  DocumentReference<Khatma> _khatmaRef(KhatmaID id) =>
      _firestore.doc(khatmaPath(id)).withConverter(
            fromFirestore: (doc, _) => Khatma.fromJson(doc.data()!),
            toFirestore: (Khatma khatma, options) => khatma.toJson(),
          );

  Query<Khatma> _khatmasRef() => _firestore
      .collection(khatmasPath())
      .withConverter(
        fromFirestore: (doc, _) => Khatma.fromJson(doc.data()!),
        toFirestore: (Khatma khatma, options) => khatma.toJson(),
      )
      .orderBy('id');

  // * Temporary search implementation.
  // * Note: this is quite inefficient as it pulls the entire khatma list
  // * and then filters the data on the client
  Future<List<Khatma>> search(String query) async {
    // 1. Get all khatmas from Firestore
    final khatmasList = await fetchKhatmasList();
    // 2. Perform client-side filtering
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
  return khatmasRepository.watchKhatmasList();
}

@riverpod
Future<List<Khatma>> khatmasListFuture(KhatmasListFutureRef ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.fetchKhatmasList();
}

@riverpod
Stream<Khatma?> khatmaStream(KhatmaStreamRef ref, KhatmaID id) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.watchKhatma(id);
}

@riverpod
Future<Khatma?> khatmaFuture(KhatmaFutureRef ref, KhatmaID id) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  return khatmasRepository.fetchKhatma(id);
}
