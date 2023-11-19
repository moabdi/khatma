import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
part 'part_provider.g.dart';

final Map unitPathMap = {
  SplitUnit.sourat.name: "sourat.json",
  SplitUnit.juzz.name: "warsh/juzz.json",
  SplitUnit.hizb.name: "warsh/hizb.json",
  SplitUnit.rubue.name: "warsh/hizb.json",
  SplitUnit.thumun.name: "warsh/hizb.json",
};

@riverpod
FutureOr<List<Part>> parts(PartsRef ref, String unit) async {
  final String responseData =
      await rootBundle.loadString('assets/quran/en/${unitPathMap[unit]}');
  final List<dynamic> dataSourat = json.decode(responseData);

  return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
}
