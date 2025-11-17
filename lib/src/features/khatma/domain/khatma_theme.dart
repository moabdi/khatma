import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

class KhatmaTheme {
  final String color;
  final String icon;
  final String variant;

  const KhatmaTheme({
    required this.color,
    required this.icon,
    this.variant = 'light',
  });

  Color get hexColor => HexColor(color);

  KhatmaTheme copyWith({
    String? color,
    String? icon,
    String? variant,
  }) {
    return KhatmaTheme(
      color: color ?? this.color,
      icon: icon ?? this.icon,
      variant: variant ?? this.variant,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KhatmaTheme &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          icon == other.icon &&
          variant == other.variant;

  @override
  int get hashCode => color.hashCode ^ icon.hashCode ^ variant.hashCode;
}

/// Default Khatma theme
const KhatmaTheme kDefaultKhatmaTheme = KhatmaTheme(
  color: "#00A862",
  icon: "kaaba.ico",
  variant: 'light',
);

/// Predefined Khatma colors
LinkedHashMap<String, Color> khatmaColorMap =
    LinkedHashMap<String, Color>.from({
  HexColor("#00A862").toHex(): HexColor("#00A862"),
  HexColor("#DD642E").toHex(): HexColor("#DD642E"),
  HexColor("#0F65E6").toHex(): HexColor("#0F65E6"),
  HexColor("#713CE7").toHex(): HexColor("#713CE7"),
  HexColor("#E01497").toHex(): HexColor("#E01497"),
  HexColor("#DD642E").toHex(): HexColor("#DD642E"),
});

List<String> khatmaColorHexList = khatmaColorMap.keys.toList();

