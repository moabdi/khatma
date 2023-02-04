import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
import 'package:khatma/src/features/khatma/enums/khatma_enums.dart';

class PartsRepository {
  Future<List<Part>> fetchSouratList() async {
    final String responseSourat =
        await rootBundle.loadString('assets/quran/en/sourat.json');
    final dataSourat = await json.decode(responseSourat);
    return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
  }

  Stream<List<Part>> watchSouratList() async* {
    yield* fetchSouratList().asStream();
  }

  Future<List<Part>> fetchPartList() async {
    final String responseSourat =
        await rootBundle.loadString('assets/quran/en/warsh/parts.json');
    final dataSourat = await json.decode(responseSourat);
    return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
  }

  Future<List<Part>> fetchJuzzList() async {
    List<Part> parts = await fetchPartList();
    int id = 0;
    return parts
        .where((part) => part.id % 2 == 1)
        .map((part) => part..id = ++id)
        .toList();
  }

  Stream<List<Part>> watchPartList() async* {
    yield* fetchPartList().asStream();
  }

  Stream<Part?> watchSourat(int id) {
    return watchSouratList()
        .map((sourats) => sourats.firstWhere((sourat) => sourat.id == id));
  }

  Stream<Part?> watchHizb(int id) {
    return watchPartList()
        .map((sourats) => sourats.firstWhere((sourat) => sourat.id == id));
  }

  Stream<Part?> watchJuzz(int id) {
    int idJuzz = id * 2 - 1;
    return watchPartList()
        .map((sourats) => sourats.firstWhere((sourat) => sourat.id == idJuzz));
  }
}

final partsRepositoryProvider = Provider<PartsRepository>((ref) {
  return PartsRepository();
});

final souratListStreamProvider = StreamProvider.autoDispose<List<Part>>((ref) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.watchSouratList();
});

final souratListFutureProvider = FutureProvider.autoDispose<List<Part>>((ref) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.fetchSouratList();
});

final partListStreamProvider = StreamProvider.autoDispose<List<Part>>((ref) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.watchPartList();
});

final partsListFutureProvider =
    FutureProvider.autoDispose.family<List<Part>, SplitUnit>((ref, unit) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  switch (unit) {
    case SplitUnit.sourat:
      {
        return khatmasRepository.fetchSouratList();
      }
    case SplitUnit.hizb:
      {
        return khatmasRepository.fetchPartList();
      }
    case SplitUnit.juzz:
      {
        return khatmasRepository.fetchJuzzList();
      }
    case SplitUnit.quart:
      {
        return khatmasRepository.fetchPartList();
      }
    case SplitUnit.roubaa:
      {
        return khatmasRepository.fetchPartList();
      }
  }
});

final partListFutureProvider = FutureProvider.autoDispose<List<Part>>((ref) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.fetchPartList();
});

final souratProvider = StreamProvider.autoDispose.family<Part?, int>((ref, id) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.watchSourat(id);
});

final hizbProvider = StreamProvider.autoDispose.family<Part?, int>((ref, id) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.watchHizb(id);
});
final juzzbProvider = StreamProvider.autoDispose.family<Part?, int>((ref, id) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  return khatmasRepository.watchJuzz(id);
});
