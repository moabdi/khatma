import 'dart:convert';

class Settings {
  String riwaya;

  Settings({
    this.riwaya = "hafs",
  });

  Map<String, dynamic> toMap() {
    return {
      'riwayat': riwaya,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      riwaya: map['riwayat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source));

  Settings copyWith({
    String? language,
    bool? useDarkTheme,
    String? riwaya,
  }) {
    return Settings(
      riwaya: riwaya ?? this.riwaya,
    );
  }
}
