import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
part 'part_list_async_notifier.g.dart';

@riverpod
class PartListStateAsyncNotifier extends _$PartListStateAsyncNotifier {
  @override
  FutureOr<List<Part>> build() async {
    final String responseSourat =
        await rootBundle.loadString('assets/quran/en/sourat.json');
    final List<dynamic> dataSourat = json.decode(responseSourat);

    return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
  }
}
