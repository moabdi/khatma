import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khatma/src/features/khatma/personal/domain/khatma.dart';
import 'package:khatma/src/features/settings/application/setting_provider.dart';
import 'package:khatma/src/utils/delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:khatma/src/features/khatma/personal/domain/part.dart';
part 'part_provider.g.dart';

final Map unitPathMap = {
  SplitUnit.juzz.name: "juzz.json",
  SplitUnit.hizb.name: "hizb.json",
};

@riverpod
FutureOr<List<Part>> parts(Ref ref, String unit) async {
  String riwaya = ref.watch(settingsProvider).riwaya;

  await delay(true, milliseconds: 300);
  final String responseData =
      await rootBundle.loadString('assets/quran/$riwaya/${unitPathMap[unit]}');
  final List<dynamic> dataSourat = json.decode(responseData);

  return List<Part>.from(dataSourat.map((sourat) => Part.fromMap(sourat)));
}
