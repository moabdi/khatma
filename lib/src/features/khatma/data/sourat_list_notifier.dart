import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';

class SouratListStateNotifier extends StateNotifier<List<Part>> {
  SouratListStateNotifier() : super([]);

  Future<void> fetchSouratList() async {
    if (state.isEmpty) {
      final String responseSourat =
          await rootBundle.loadString('assets/quran/en/sourat.json');
      final dataSourat = json.decode(responseSourat);
      state = List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
    }
  }
}

final souratListProvider =
    StateNotifierProvider<SouratListStateNotifier, List<Part>>(
        (ref) => SouratListStateNotifier());
