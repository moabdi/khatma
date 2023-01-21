class Language {
  final String flag;
  final String name;
  final String code;

  Language(this.flag, this.name, this.code);

  static List<Language> languageList() {
    return <Language>[
      Language("🇲🇦", "اَلْعَرَبِيَّةُ", "ar"),
      Language("🇺🇸", "English", "en"),
      Language("🇫🇷", "Français", "fr"),
      Language("🇪🇸", "Espagnola", "es")
    ];
  }

  static of(String code) {
    return languageList().firstWhere((element) => element.code == code).name;
  }
}
