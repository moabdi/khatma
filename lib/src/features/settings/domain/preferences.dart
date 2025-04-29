import 'dart:convert';

class Preferences {
  String language = 'en';
  bool useDarkTheme = false;
  String riwaya;

  Preferences({
    this.language = 'en',
    this.useDarkTheme = false,
    required this.riwaya,
  });

  Map<String, dynamic> toMap() {
    return {
      'useDarkTheme': useDarkTheme,
      'language': language,
      'riwayat': riwaya,
    };
  }

  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      useDarkTheme: map['useDarkTheme'],
      riwaya: map['riwayat'],
      language: map['language'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Preferences.fromJson(String source) =>
      Preferences.fromMap(json.decode(source));

  Preferences copyWith({
    String? language,
    bool? useDarkTheme,
    String? riwaya,
  }) {
    return Preferences(
      language: language ?? this.language,
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
      riwaya: riwaya ?? this.riwaya,
    );
  }
}
