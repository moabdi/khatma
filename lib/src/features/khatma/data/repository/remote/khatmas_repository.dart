import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/authentication/data/auth_repository.dart';
import 'package:khatma/src/features/khatma/data/mappers/khatma_mappers.dart';
import 'package:khatma/src/features/khatma/data/model/khatma_dto.dart' hide KhatmaID;
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'khatmas_repository.g.dart';

class KhatmasRepository {
  const KhatmasRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String khatmasPath(String userUid, KhatmaType type) {
    switch (type) {
      case KhatmaType.personal:
         return 'users/$userUid/khatmat';
      case KhatmaType.shared:
         return 'shared_khatmat';
      case KhatmaType.hifz:
         return 'users/$userUid/hifz';
    }
  }
  static String khatmaPath(String userUid, KhatmaID id,  KhatmaType type) {
    return khatmasPath(userUid, type) + '/$id';
    }

  Future<List<Khatma>> fetchKhatmasList(String userId, KhatmaType type) async {
    if (kDebugMode) {
      debugPrint('[fetchKhatmasList] userId: $userId');
    }
    final ref = _khatmasRef(userId, type);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Khatma>> watchKhatmasList(String userId, {KhatmaType type = KhatmaType.personal}) {
    if (kDebugMode) {
      debugPrint('[watchKhatmasList] userId: $userId');
    }
    final ref = _khatmasRef(userId, type);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<Khatma?> fetchKhatma(String userId, KhatmaID id, {KhatmaType type = KhatmaType.personal}) async {
    if (kDebugMode) {
      debugPrint('[fetchKhatma] userId: $userId, khatmaId: $id');
    }
    final ref = _khatmaRef(userId, id, type);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  Stream<Khatma?> watchKhatma(String userId, KhatmaID id,  {KhatmaType type = KhatmaType.personal}) {
    if (kDebugMode) {
      debugPrint('[watchKhatma] userId: $userId, khatmaId: $id');
    }
    final ref = _khatmaRef(userId, id, type);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<Khatma> create(String userId, Khatma khatma) async {
    if (kDebugMode) {
      debugPrint('[create] userId: $userId, khatma: ${khatma.name}');
    }
    final docRef =
        await _firestore.collection(khatmasPath(userId, khatma.type)).add(khatma.toDto().toJson());
    final newKhatma = khatma.copyWith(id: docRef.id);
    await docRef.set(newKhatma.toDto().toJson());
    return newKhatma;
  }

  Future<Khatma> update(String userId, Khatma khatma) async {
    if (kDebugMode) {
      debugPrint('[update] userId: $userId, khatma: ${khatma.name}');
    }
    final ref = _khatmaRef(userId, khatma.id!, khatma.type);
    await ref.set(khatma);
    return khatma;
  }

  Future<void> delete(String userId, Khatma khatma) {
    if (kDebugMode) {
      debugPrint('[delete] userId: $userId, khatmaId: ${khatma.id}');
    }
    return _firestore.doc(khatmaPath(userId, khatma.id!, khatma.type)).delete();
  }

  DocumentReference<Khatma> _khatmaRef(String userId, KhatmaID id, KhatmaType type) {
    return _firestore.doc(khatmaPath(userId, id, type)).withConverter(
          fromFirestore: (doc, _) {
            final data = doc.data()!;
            data['id'] = doc.id;
            return KhatmaDto.fromJson(data).toDomain();
          },
          toFirestore: (Khatma khatma, options) => khatma.toDto().toJson(),
        );
  }

  Query<Khatma> _khatmasRef(String userId, KhatmaType type) {
    return _firestore.collection(khatmasPath(userId, type)).withConverter(
          fromFirestore: (doc, _) {
            final data = doc.data()!;
            data['id'] = doc.id;
            return KhatmaDto.fromJson(data).toDomain();
          },
          toFirestore: (Khatma khatma, options) => khatma.toDto().toJson(),
        );
  }

  Future<List<Khatma>> search(String userId, KhatmaType type, String query) async {
    if (kDebugMode) {
      debugPrint('[search] userId: $userId, query: "$query"');
    }
    final khatmasList = await fetchKhatmasList(userId, type);
    return khatmasList
        .where(
            (khatma) => khatma.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

@Riverpod(keepAlive: true)
KhatmasRepository khatmasRepository(Ref ref) {
  return KhatmasRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Khatma>> khatmasListStream(Ref ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatmasList(userUid);
}

@riverpod
Future<List<Khatma>> khatmasListFuture(Ref ref) {
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatmasList(userUid, KhatmaType.personal);
}

@riverpod
Stream<Khatma?> khatmaStream(Ref ref, KhatmaID id) {
  delay(true);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.watchKhatma(userUid, id);
}

@riverpod
Future<Khatma?> khatmaFuture(Ref ref, KhatmaID id) async {
  await delay(true, milliseconds: 100);
  final khatmasRepository = ref.watch(khatmasRepositoryProvider);
  String userUid = ref.read(authRepositoryProvider).currentUser!.uid;
  return khatmasRepository.fetchKhatma(userUid, id);
}
