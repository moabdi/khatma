import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:khatma/src/features/khatma/domain/khatma.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

extension KhatmaExtension on Khatma {
  double get completionPercent {
    if (readParts?.isEmpty ?? false) return 0;
    return completedPartIds.length / unit.count;
  }

  Duration get duration {
    if (lastRead == null) return DateTime.now().difference(createDate);
    return DateTime.now().difference(lastRead!);
  }

  List<int> get readPartIds {
    return readParts?.map((part) => part.id).toList() ?? [];
  }

  bool get isExpired {
    if (recurrence == null || recurrence!.endDate == null) return false;
    return recurrence!.endDate!.isBefore(DateTime.now());
  }

  String get remainingDays {
    if (isExpired) return '0';
    if (recurrence == null || recurrence!.endDate == null) return '-1';
    return recurrence!.endDate!.difference(DateTime.now()).inDays.toString();
  }

  String get remainingParts {
    return (unit.count - readPartIds.length).toString();
  }

  List<int> get remainingPartsList {
    return List.generate(unit.count, (index) => index + 1)
        .where((part) => !readPartIds.contains(part))
        .toList();
  }

  List<int> get completedPartIds {
    return readParts
            ?.where((part) => part.endDate != null)
            .map((part) => part.id)
            .toSet()
            .toList() ??
        [];
  }

  bool get isCompleted {
    return completedPartIds.length == unit.count;
  }

  bool get isStarted {
    return completedPartIds.isNotEmpty;
  }

  bool get isNotStarted {
    return completedPartIds.isEmpty;
  }

  KhatmaTheme get style {
    return this.theme ??
        KhatmaTheme(color: khatmaColorMap.keys.first, icon: "kaaba.ico");
  }
}

LinkedHashMap<String, Color> khatmaColorMap =
    LinkedHashMap<String, Color>.from({
  HexColor("#00A862").toHex(): HexColor("#00A862"),
  Colors.deepPurple.toHex(): Colors.deepPurple,
  Colors.blue.toHex(): Colors.blue,
  Colors.deepOrange.toHex(): Colors.deepOrange,
  Colors.pink.toHex(): Colors.pink,
  Colors.brown.toHex(): Colors.brown,
});

List<String> khatmaColorHexList = khatmaColorMap.keys.toList();

extension ColorExtension on KhatmaTheme {
  Color get hexColor => HexColor(color);
}
