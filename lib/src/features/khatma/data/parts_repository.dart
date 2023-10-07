import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';

class PartsRepository {
  List<Part> _souratList = [];
  List<Part> _hizbList = [];
  List<Part> _juzzList = [];

  Future<List<Part>> fetchSouratList() async {
    if (_souratList.isEmpty) {
      final String responseSourat =
          await rootBundle.loadString('assets/quran/en/sourat.json');
      final dataSourat = await json.decode(responseSourat);
      _souratList =
          List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
    }
    return _souratList;
  }

  Future<List<Part>> fetchHizbList() async {
    if (_hizbList.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/quran/en/warsh/hizb.json');
      final data = await json.decode(response);
      _hizbList = List<Part>.from(data.map((sourat) => Part.fromMap(sourat)));
    }
    return _hizbList;
  }

  Future<List<Part>> fetchJuzzList() async {
    if (_juzzList.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/quran/en/warsh/juzz.json');
      final data = await json.decode(response);
      _juzzList = List<Part>.from(data.map((sourat) => Part.fromMap(sourat)));
    }
    return _juzzList;
  }
}

final partsRepositoryProvider = Provider<PartsRepository>((ref) {
  return PartsRepository();
});

final partsListFutureProvider =
    FutureProvider.family.autoDispose<List<Part>, SplitUnit>((ref, unit) {
  final khatmasRepository = ref.watch(partsRepositoryProvider);
  switch (unit) {
    case SplitUnit.sourat:
      {
        return khatmasRepository.fetchSouratList();
      }
    case SplitUnit.juzz:
      {
        return khatmasRepository.fetchJuzzList();
      }
    default:
      {
        return khatmasRepository.fetchHizbList();
      }
  }
});
