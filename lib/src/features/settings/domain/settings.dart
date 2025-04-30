import 'dart:convert';

class Settings {
  String language = 'en';
  bool useDarkTheme = false;
  String riwaya = "hafs";

  Settings({
    this.language = 'en',
    this.useDarkTheme = false,
    this.riwaya = "hafs",
  });

  Map<String, dynamic> toMap() {
    return {
      'useDarkTheme': useDarkTheme,
      'language': language,
      'riwayat': riwaya,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      useDarkTheme: map['useDarkTheme'],
      riwaya: map['riwayat'],
      language: map['language'],
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
      language: language ?? this.language,
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
      riwaya: riwaya ?? this.riwaya,
    );
  }
}
