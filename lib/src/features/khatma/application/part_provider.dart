import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/khatma/domain/part.dart';
part 'part_provider.g.dart';

final Map unitPathMap = {
  SplitUnit.juzz.name: "warsh/juzz.json",
  SplitUnit.hizb.name: "warsh/hizb.json",
};

@riverpod
FutureOr<List<Part>> parts(Ref ref, String unit) async {
  await delay(true, milliseconds: 300);
  final String responseData =
      await rootBundle.loadString('assets/quran/en/${unitPathMap[unit]}');
  final List<dynamic> dataSourat = json.decode(responseData);

  return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
}
