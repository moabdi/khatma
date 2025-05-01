import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(_getSystemLocale()) {
    _loadLocaleFromPrefs();
  }

  static Locale _getSystemLocale() {
    final systemLocale = PlatformDispatcher.instance.locale;
    return Locale(systemLocale.languageCode);
  }

  Future<void> _loadLocaleFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString('locale');

    if (savedLocale != null && savedLocale.isNotEmpty) {
      final candidate = Locale(savedLocale);
      if (supportedLocales
          .any((l) => l.languageCode == candidate.languageCode)) {
        state = candidate;
      }
    }
  }

  Future<void> _saveLocaleToPrefs(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', localeCode);
  }

  void setLocale(String localeCode) {
    state = Locale(localeCode);
    _saveLocaleToPrefs(localeCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

const supportedLocales = [
  Locale('en'),
  Locale('fr'),
  Locale('ar'),
];
