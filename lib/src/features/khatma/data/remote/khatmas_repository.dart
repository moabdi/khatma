import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/data/local/local_khatma_repository.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../local/have_khatma_repository.dart';

part 'khatmas_repository.g.dart';

class KhatmasRepository {
  const KhatmasRepository(this._firestore, this._localRepo, {required bool useLocal});
  final FirebaseFirestore _firestore;

  final bool useLocal = true;

  final LocalKhatmaRepository _localRepo;

  static String khatmasPath(String userUid) => 'users/$userUid/khatmat';

  static String khatmaPath(String userUid, KhatmaID id) =>
      'users/$userUid/khatmat/$id';


  Future<List<Khatma>> fetchKhatmasList(String userId) async {
    final ref = _khatmasRef(userId);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Khatma>> watchKhatmasList(String userId) {
    final ref = _khatmasRef(userId);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Khatma?> fetchKhatma(String userId, KhatmaID id) async {
    if (useLocal) {
      return _localRepo.getById(id);
    } else {
      final ref = _khatmaRef(userId, id);
      final snapshot = await ref.get();
      return snapshot.data();
    }
  }

  Stream<Khatma?> watchKhatma(String userId, KhatmaID id) {
    if (useLocal) {
      // fallback to just fetch once
      return Stream.fromFuture(_localRepo.getById(id));
    } else {
      final ref = _khatmaRef(userId, id);
      return ref.snapshots().map((snapshot) => snapshot.data());
    }
  }

  Future create(String userId, Khatma khatma) async {
    if (useLocal) {
      final id = khatma.id ?? const Uuid().v4();
      await _localRepo.save(khatma.copyWith(id: id));
    } else {
      return _firestore.collection(khatmasPath(userId)).add(khatma.toJson());
    }
  }

  Future update(String userId, Khatma khatma) async {
    if (useLocal) {
      await _localRepo.save(khatma);
    } else {
      final ref = _khatmaRef(userId, khatma.id!);
      return ref.set(khatma);
    }
  }

  Future<void> deleteById(String userId, KhatmaID id) async {
    if (useLocal) {
      await _localRepo.deleteById(id);
    } else {
      return _firestore.doc(khatmaPath(userId, id)).delete();
    }
  }

  DocumentReference<Khatma> _khatmaRef(String userId, KhatmaID id) =>
      _firestore.doc(khatmaPath(userId, id)).withConverter(
            fromFirestore: (doc, _) {
              final data = doc.data()!;
              data['id'] = doc.id;
              return Khatma.fromJson(data);
            },
            toFirestore: (Khatma khatma, options) => khatma.toJson(),
          );

  Query<Khatma> _khatmasRef(String userId) =>
      _firestore.collection(khatmasPath(userId)).withConverter(
            fromFirestore: (doc, _) {
              final data = doc.data()!;
              data['id'] = doc.id;
              return Khatma.fromJson(data);
            },
            toFirestore: (Khatma khatma, options) => khatma.toJson(),
          );

  // * Temporary search implementation.
  // * Note: this is quite inefficient as it pulls the entire khatma list
  // * and then filters the data on the client
  Future<List<Khatma>> search(String userId, String query) async {
    // 1. Get all khatmas from Firestore
    final khatmasList = await fetchKhatmasList(userId);
    // 2. Perform client-side filtering
    return khatmasList
        .where(
            (khatma) => khatma.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
KhatmasRepository khatmasRepository(KhatmasRepositoryRef ref) {
  final firestore = FirebaseFirestore.instance;
  final localRepo = ref.watch(localKhatmaRepositoryProvider);
  return KhatmasRepository(firestore, localRepo, useLocal: true);
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
